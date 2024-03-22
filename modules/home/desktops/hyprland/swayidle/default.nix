{ options, config, lib, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.desktops.hyprland.swayidle;
in
{
  options.custom.desktops.hyprland.swayidle = with types; {
    enable = mkBoolOpt config.custom.desktops.hyprland.enable "Enable swayidle";

    timeout = {
      lock = mkOption {
        type = int;
        default = 360;
        description = "The time in seconds after which the screen should be locked. 0 to disable.";
      };
      suspend = mkOption {
        type = int;
        default = 600;
        description = "The time in seconds after which the system should be suspended. 0 to disable.";
      };
    };
  };

  config = mkIf cfg.enable {
    services.swayidle = {
      enable = true;
      systemdTarget = "hyprland-session.target";

      # [options](https://github.com/swaywm/swayidle/blob/master/swayidle.1.scd)
      timeouts = [
        (mkIf (cfg.timeout.lock > 0) { timeout = cfg.timeout.lock; command = "${config.programs.swaylock.package}/bin/swaylock --grace 30"; })
        (mkIf (cfg.timeout.suspend > 0) { timeout = cfg.timeout.suspend; command = "${pkgs.systemd}/bin/systemctl suspend"; })
      ];
      events = [
        { event = "before-sleep"; command = "${config.programs.swaylock.package}/bin/swaylock --grace 0 --fade-in 0"; }
      ];
    };
  };
}
