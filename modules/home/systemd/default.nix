{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.systemd;
in
{
  options.dafitt.systemd = with types; {
    enable = mkBoolOpt true "Whether to enable systemd user configuration.";
  };

  config = mkIf cfg.enable {
    systemd.user.settings.Manager = {
      #$ man systemd-user.conf

      # reduce restart rate limiting time
      DefaultStartLimitIntervalSec = "2s";
    };
  };
}
