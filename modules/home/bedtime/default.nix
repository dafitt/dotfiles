# A module to remeber you to go to sleep early without being too annoying

{ config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.bedtime;
in
{
  options.dafitt.bedtime = with types; {
    enable = mkEnableOption "bedtimer, which tells you to go to sleep at night by muting sound";
  };

  config = mkIf cfg.enable {
    systemd.user.services."bedtime-mute" = {
      Unit.Description = "muting the output volume, to tell you to go to sleep";
      Service = {
        Type = "oneshot";
        ExecStart = "${pkgs.pulsemixer}/bin/pulsemixer --mute";
      };
    };
    systemd.user.timers."bedtime-mute" = {
      Unit.Description = "muting the output volume, to tell you to go to sleep";
      Timer = {
        OnCalendar = "22..23,00..05:00/15";
      };
      Install.WantedBy = [ "timers.target" ];
    };
  };
}
