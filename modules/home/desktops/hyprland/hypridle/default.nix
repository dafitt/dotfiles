{ options, config, lib, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.desktops.hyprland.hypridle;
  hyprlandCfg = config.wayland.windowManager.hyprland;
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
    custom.desktops.hyprland.hyprlock.enable = true;

    # https://github.com/hyprwm/hypridle/blob/main/nix/hm-module.nix
    services.hypridle = {
      enable = true;
      beforeSleepCmd = getExe config.programs.hyprlock.package; # ??? "${pkgs.systemd}/bin/loginctl lock-session";
      lockCmd = getExe config.programs.hyprlock.package;

      listeners = [
        (mkIf (cfg.timeouts.lock > 0) {
          timeout = cfg.timeouts.lock;
          onTimeout = "${getExe config.programs.hyprlock.package}";
        })
        {
          timeout = if (cfg.timeouts.lock > 0) then (cfg.timeouts.lock + 10) else 360;
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
