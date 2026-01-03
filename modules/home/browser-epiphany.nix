{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dafitt.browser-epiphany;
in
{
  options.dafitt.browser-epiphany = with types; {
    setAsDefaultBrowser = mkEnableOption "making it the default web browser";

    autostart = mkOption {
      type = bool;
      default = cfg.setAsDefaultBrowser;
      description = "Whether to autostart at user login.";
    };
    workspace = mkOption {
      type = int;
      default = 1;
      description = "Which workspace is mainly to be used for this application.";
    };
  };

  config = {
    # Simple and easy to use web browser
    home.packages = with pkgs; [ epiphany ];

    wayland.windowManager.hyprland.settings = {
      bind = optionals cfg.setAsDefaultBrowser [
        "Super&Alt, W, exec, uwsm app -- ${getExe pkgs.epiphany}"
      ];
      exec-once = optionals cfg.autostart [
        "[workspace ${toString cfg.workspace} silent] ${getExe pkgs.epiphany}"
      ];
    };
    programs.niri.settings = {
      binds."Mod+Alt+W" = mkIf cfg.setAsDefaultBrowser {
        action.spawn-sh = "uwsm app -- ${getExe pkgs.epiphany}";
      };
      spawn-at-startup = optionals cfg.autostart [
        { sh = "uwsm app -- ${getExe pkgs.epiphany}"; }
      ];
    };
  };
}
