{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.thunar;
in
{
  options.dafitt.thunar = with types; {
    enable = mkEnableOption "thunar";
    setAsDefaultFileManager = mkEnableOption "making it the default file manager";

    autostart = mkBoolOpt cfg.setAsDefaultFileManager "Whether to autostart at user login.";
    workspace = mkOpt int 3 "Which workspace is mainly to be used for this application.";
  };

  config = mkIf cfg.enable {
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
