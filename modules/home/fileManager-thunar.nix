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
    home.packages = with pkgs.xfce; [ thunar ];

    dbus.packages = with pkgs.xfce; [
      thunar
      xfconf
    ];

    wayland.windowManager.hyprland.settings = {
      bind = mkIf cfg.setAsDefaultFileManager [
        "SUPER_ALT, F, exec, uwsm app -- ${pkgs.xfce.thunar}/bin/thunar"
      ];
      exec-once = mkIf cfg.autostart [
        "[workspace ${toString cfg.workspace} silent] uwsm app -- ${pkgs.xfce.thunar}/bin/thunar"
      ];
    };
  };
}
