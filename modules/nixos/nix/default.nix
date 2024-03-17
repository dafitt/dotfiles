{ options, config, lib, pkgs, inputs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.nix;
in
{
  options.custom.nix = with types; {
    enable = mkBoolOpt true "Whether or not to manage nix configuration.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; with inputs; [
      snowfall-flake.packages.${system}.default
    ];

    nix = {
      package = pkgs.nixUnstable;

      settings = {
        experimental-features = "nix-command flakes";
        http-connections = 50;
        warn-dirty = false;
        log-lines = 50;
        sandbox = "relaxed";
        auto-optimise-store = true;
        trusted-users = [ "root" ];
        allowed-users = [ "@wheel" ];
      };
      # ???: config.apps.tools.direnv.enable
      #// (lib.optionalAttrs config.apps.tools.direnv.enable {
      #  keep-outputs = true;
      #  keep-derivations = true;
      #});

      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
      };

      # flake-utils-plus
      generateRegistryFromInputs = true;
      generateNixPathFromInputs = true;
      linkInputs = true;

      # Make `nix run nixpkgs#nixpkgs` use the same nixpkgs as the one used by this flake.
      registry."nixpkgs".flake = inputs.nixpkgs;

      # ???: disable nix-channel, we use flakes instead.
      #channel.enable = false;
    };

    # Make `nix repl '<nixpkgs>'` use the same nixpkgs as the one used by this flake.
    environment.etc."nix/inputs/nixpkgs".source = "${inputs.nixpkgs}";
    nix.nixPath = [ "/etc/nix/inputs" ];

    # Multitheaded and faster building (make)
    environment.variables.MAKEFLAGS = "-j$(expr $(nproc) \+ 1)";
  };
}