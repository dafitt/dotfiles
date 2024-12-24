{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.hyprland.hypridle;
  hyprlockCfg = config.programs.hyprlock;
  hyprlandCfg = config.wayland.windowManager.hyprland;

  locking_enabled = cfg.timeouts.lock > 0 && hyprlockCfg.enable;
in
{
  options.dafitt.hyprland.hypridle = with types; {
    enable = mkBoolOpt config.dafitt.hyprland.enable "Whether to enable hypridle.";
    sleepTriggersLock = mkBoolOpt true "Whether to lock before going to sleep";
    timeouts = {
      lock = mkOption {
        description = "The time in seconds after which the screen should be locked. 0 to disable.";
        type = int;
        default = 360;
      };
      suspend = mkOption {
        description = "The time in seconds after which the system should be suspended. 0 to disable.";
        type = int;
        apply = v: assert v >= cfg.timeouts.lock || v == 0; v;
        default = 600;
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
          before_sleep_cmd = mkIf (hyprlockCfg.enable && cfg.sleepTriggersLock) "${pkgs.systemd}/bin/loginctl lock-session";
          after_sleep_cmd = "${hyprlandCfg.package}/bin/hyprctl dispatch dpms on && ${pkgs.systemd}/bin/systemctl restart --user wlsunset.service";
          lock_cmd = mkIf hyprlockCfg.enable "${pkgs.procps}/bin/pidof hyprlock || ${hyprlockCfg.package}/bin/hyprlock --immediate";
        };

        listener = [
          # screen dim brightness
          {
            timeout = if locking_enabled then (cfg.timeouts.lock / 2) else 180;
            on-timeout = "${pkgs.brightnessctl}/bin/brightnessctl -s set 10";
            on-resume = "${pkgs.brightnessctl}/bin/brightnessctl -r";
          }
          # lock
          (mkIf locking_enabled {
            timeout = cfg.timeouts.lock;
            on-timeout = "${pkgs.systemd}/bin/loginctl lock-session";
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
    # disable temporarily #$ systemctl stop --user hypridle
  };
}
