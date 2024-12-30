{ options, config, lib, pkgs, inputs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.nix;
in
{
  options.dafitt.nix = with types; {
    enable = mkEnableOption "nix configuration";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; with inputs; [
      snowfall-flake.packages.${system}.default
    ];

    programs.git.enable = true;

    nix = {
      package = pkgs.nixVersions.latest;

      settings = {
        experimental-features = [ "nix-command" "flakes" ];
        http-connections = 50;
        warn-dirty = false;
        log-lines = 50;
        auto-optimise-store = true;
        trusted-users = [ "root" ];
        allowed-users = [ "@wheel" ];
      }
      // optionalAttrs config.programs.direnv.enable {
        keep-outputs = true;
        keep-derivations = true;
      };

      gc = {
        automatic = true;
        dates = "monthly";
        options = "--delete-older-than +12";
      };

      # disable nix-channel, we use flakes instead.
      channel.enable = false;
    };

    # repair command-not-found database
    programs.command-not-found.dbPath = inputs.programsdb.packages.${pkgs.system}.programs-sqlite;
  };
}
