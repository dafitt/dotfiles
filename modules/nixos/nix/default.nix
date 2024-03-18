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

    programs.git.enable = true;

    nix = {
      settings = {
        experimental-features = "nix-command flakes";
        http-connections = 50;
        warn-dirty = false;
        log-lines = 50;
        sandbox = "relaxed";
        auto-optimise-store = true;
        trusted-users = [ "root" ];
        allowed-users = [ "@wheel" ];
      } // (lib.optionalAttrs config.custom.development.direnv.enable {
        keep-outputs = true;
        keep-derivations = true;
      });

      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
      };

      # Make `nix run nixpkgs#nixpkgs` use the same nixpkgs as the one used by this flake.
      registry."nixpkgs".flake = inputs.nixpkgs;
      registry."unstable".flake = inputs.unstable;

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
