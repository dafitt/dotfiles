{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.desktops.hyprland.hypridle;
  hyprlockCfg = config.programs.hyprlock;
  hyprlandCfg = config.wayland.windowManager.hyprland;

  locking_enabled = cfg.timeouts.lock > 0 && hyprlockCfg.enable;
in
{
  options.dafitt.desktops.hyprland.hypridle = with types; {
    enable = mkBoolOpt config.dafitt.desktops.hyprland.enable "Enable hypridle.";
    sleepTriggersLock = mkBoolOpt true "Whether or not to lock before going to sleep";
    timeouts = {
      lock = mkOption {
        type = int;
        default = 360;
        description = "The time in seconds after which the screen should be locked. 0 to disable.";
      };
      suspend = mkOption {
        #TODO assertion: suspend must be greater than lock
        type = int;
        default = 600;
        description = "The time in seconds after which the system should be suspended. 0 to disable.";
      };
    };
  };

  config = mkIf cfg.enable {
    # https://wiki.hyprland.org/Hypr-Ecosystem/hypridle/
    services.hypridle = {
      enable = true;

      settings = {
        general = {
          # declaration for dbus events
          before_sleep_cmd = mkIf (hyprlockCfg.enable && cfg.sleepTriggersLock) "${getExe hyprlockCfg.package} --immediate";
          after_sleep_cmd = "${hyprlandCfg.package}/bin/hyprctl dispatch dpms on && ${pkgs.systemd}/bin/systemctl restart --user wlsunset.service";
          lock_cmd = mkIf hyprlockCfg.enable "${getExe hyprlockCfg.package}";
        };

        listener = [
          # screen dim brightness
          {
            timeout = if locking_enabled then (cfg.timeouts.lock / 2) else 180;
            on-timeout = "brightnessctl - sd rgb:kbd_backlight set 10";
            on-resume = "brightnessctl -rd rgb:kbd_backlight";
          }
          # lock
          (mkIf locking_enabled {
            timeout = cfg.timeouts.lock;
            on-timeout = "${getExe hyprlockCfg.package}";
          })
          # screen off
          {
            timeout = if locking_enabled then (cfg.timeouts.lock + config.programs.hyprlock.settings.general.grace) else 360;
            on-timeout = "${hyprlandCfg.package}/bin/hyprctl dispatch dpms off";
            on-resume = "${hyprlandCfg.package}/bin/hyprctl dispatch dpms on && ${pkgs.systemd}/bin/systemctl restart --user wlsunset.service";
          }
          # suspend
          (mkIf (cfg.timeouts.suspend > 0) {
            timeout = cfg.timeouts.suspend;
            on-timeout = "${pkgs.systemd}/bin/systemctl suspend";
          })
        ];
      };
    };
  };
}
