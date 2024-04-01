{ options, config, lib, pkgs, inputs, ... }:

with lib;
with lib.custom;
{
  environment.systemPackages = with pkgs; with inputs; [
    snowfall-flake.packages.${system}.default
  ];

  programs.git.enable = true;

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" "repl-flake" ];
      http-connections = 50;
      warn-dirty = false;
      log-lines = 50;
      auto-optimise-store = true;
      trusted-substituters = config.nix.settings.substituters;
      trusted-users = [ "root" ];
      allowed-users = [ "@wheel" config.custom.users.main.username ];
    }
    // (lib.optionalAttrs config.custom.development.direnv.enable {
      keep-outputs = true;
      keep-derivations = true;
    });

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    # TODO: 24.05 remove nixpkgs, see: https://github.com/NixOS/nixpkgs/pull/254405
    # Make `nix run nixpkgs#nixpkgs` use the same nixpkgs as the one used by this flake.
    #registry."nixpkgs".flake = inputs.nixpkgs;
    registry."nixpkgs".to = {
      type = "path";
      path = pkgs.path;
      narHash = builtins.readFile (pkgs.runCommandLocal "get-nixpkgs-hash"
        { nativeBuildInputs = [ pkgs.nix ]; }
        "nix-hash --type sha256 --sri ${pkgs.path} > $out");
    };
    nixPath = [ "nixpkgs=flake:nixpkgs" ];
    registry."unstable".flake = inputs.unstable;

    # disable nix-channel, we use flakes instead.
    channel.enable = false;
  };

  # but NIX_PATH is still used by many useful tools, so we set it to the same value as the one used by this flake.
  # Make `nix repl '<nixpkgs>'` use the same nixpkgs as the one used by this flake.
  environment.etc."nix/inputs/nixpkgs".source = "${inputs.nixpkgs}";

  # repair command-not-found database
  programs.command-not-found.dbPath = inputs.programsdb.packages.${pkgs.system}.programs-sqlite;

  # Multitheaded and faster building (make)
  environment.variables.MAKEFLAGS = "-j$(expr $(nproc) \+ 1)";
}
