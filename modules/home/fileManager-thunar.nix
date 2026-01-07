{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dafitt.fileManager-thunar;
in
{
  options.dafitt.fileManager-thunar = with types; {
    setAsDefaultFileManager = mkEnableOption "making it the default file manager";

    autostart = mkOption {
      type = bool;
      default = cfg.setAsDefaultFileManager;
      description = "Whether to autostart at user login.";
    };
    workspace = mkOption {
      type = int;
      default = 3;
      description = "Which workspace is mainly to be used for this application.";
    };
  };

  config = {
    home.packages = with pkgs.xfce; [
      thunar
      tumbler
    ];

    dbus.packages = with pkgs.xfce; [
      thunar
      tumbler
    ];

    wayland.windowManager.hyprland.settings = {
      bind = optionals cfg.setAsDefaultFileManager [
        "Super&Alt, F, exec, uwsm app -- ${getExe pkgs.xfce.thunar}"
      ];
      exec-once = optionals cfg.autostart [
        "[workspace ${toString cfg.workspace} silent] uwsm app -- ${getExe pkgs.xfce.thunar}"
      ];
    };
    programs.niri.settings = {
      binds."Mod+Alt+F" = mkIf cfg.setAsDefaultFileManager {
        action.spawn-sh = "uwsm app -- ${getExe pkgs.xfce.thunar}";
      };
      spawn-at-startup = optionals cfg.autostart [
        { sh = "uwsm app -- ${getExe pkgs.xfce.thunar}"; }
      ];
    };
  };
}
