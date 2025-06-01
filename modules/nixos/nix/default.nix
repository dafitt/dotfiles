{ config, lib, pkgs, inputs, ... }:

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
    programs.git.enable = true;

    nix = {
      package = pkgs.nixVersions.latest;

      settings = {
        #$ man nix.conf
        experimental-features = [ "nix-command" "flakes" ];
        allowed-users = [ "@wheel" ];
        trusted-users = [ "@wheel" ];

        auto-optimise-store = true;
        connect-timeout = 5;
        http-connections = 50;
        log-lines = 50; # more log lines in case of error
        min-free = 1 * (1024 * 1024 * 1024); # GiB # start garbage collector
        max-free = 50 * (1024 * 1024 * 1024); # GiB # until
        warn-dirty = false;
      } // optionalAttrs config.programs.direnv.enable {
        keep-derivations = true;
        keep-outputs = true;
      };

      gc = {
        automatic = true;
        dates = "monthly";
        options = "--delete-older-than 45d";
      };

      # disable nix-channel, we use flakes instead.
      channel.enable = false;
    };

    # repair command-not-found database
    programs.command-not-found.dbPath = inputs.programsdb.packages.${pkgs.system}.programs-sqlite;
  };
}
