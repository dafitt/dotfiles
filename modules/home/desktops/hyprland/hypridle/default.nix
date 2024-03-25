{ options, config, lib, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.desktops.hyprland.hypridle;
  hyprlockCfg = config.custom.desktops.hyprland.hyprlock;
  hyprlandCfg = config.wayland.windowManager.hyprland;

  locking_enabled = cfg.timeouts.lock > 0 && hyprlockCfg.enable;
in
{
  options.custom.desktops.hyprland.hypridle = with types; {
    enable = mkBoolOpt config.custom.desktops.hyprland.enable "Enable hypridle";

    timeouts = {
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
    # https://github.com/hyprwm/hypridle/blob/main/nix/hm-module.nix
    services.hypridle = {
      enable = true;

      beforeSleepCmd = mkIf hyprlockCfg.enable (getExe hyprlockCfg.package); # ??? "${pkgs.systemd}/bin/loginctl lock-session";
      lockCmd = mkIf hyprlockCfg.enable (getExe hyprlockCfg.package);

      listeners = [
        (mkIf locking_enabled {
          timeout = cfg.timeouts.lock;
          onTimeout = "${getExe hyprlockCfg.package}";
        })
        {
          timeout = if locking_enabled then (cfg.timeouts.lock + 10) else 360;
          onTimeout = "${hyprlandCfg.package}/bin/hyprctl dispatch dpms off";
          onResume = "${hyprlandCfg.package}/bin/hyprctl dispatch dpms on";
        }
        (mkIf (cfg.timeouts.suspend > 0) {
          timeout = cfg.timeouts.suspend;
          onTimeout = "${pkgs.systemd}/bin/systemctl suspend";
        })
      ];
    };
  };
}
