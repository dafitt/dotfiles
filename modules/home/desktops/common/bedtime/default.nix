{ options, config, lib, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.desktops.common.bedtime;
in
{
  options.custom.desktops.common.bedtime = with types; {
    enable = mkBoolOpt false "Wether or not to tell you to go to sleep at night";
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
