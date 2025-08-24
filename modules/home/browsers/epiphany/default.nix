{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.epiphany;
in
{
  options.dafitt.epiphany = with types; {
    enable = mkEnableOption "epiphany";
    setAsDefaultBrowser = mkEnableOption "making epiphany the default web browser";

    autostart = mkBoolOpt cfg.setAsDefaultBrowser "Whether to autostart at user login.";
    workspace = mkOpt int 1 "Which workspace is mainly to be used for this application.";
  };

  config = mkIf cfg.enable {
    # Simple and easy to use web browser
    home.packages = with pkgs; [ epiphany ];

    wayland.windowManager.hyprland.settings = {
      bind = mkIf cfg.setAsDefaultBrowser [ "SUPER_ALT, W, exec, uwsm app -- ${getExe pkgs.epiphany}" ];
      exec-once = mkIf cfg.autostart [
        "[workspace ${toString cfg.workspace} silent] ${getExe pkgs.epiphany}"
      ];
    };

    # needs inputs.xdg-autostart.homeManagerModules.xdg-autostart
    xdg.autoStart.packages = mkIf cfg.autostart [ pkgs.epiphany ];
  };
}
