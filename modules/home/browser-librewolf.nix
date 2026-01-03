{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.dafitt.browser-librewolf;
in
{
  options.dafitt.browser-librewolf = with types; {
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
    # a fork of Firefox, focused on privacy, security and freedom
    # https://librewolf.net/
    programs.librewolf = {
      enable = true;
      settings = config.programs.firefox.profiles.${config.home.username}.settings // { };
    };

    wayland.windowManager.hyprland.settings = {
      bind = optionals cfg.setAsDefaultBrowser [
        "Super&Alt, W, exec, uwsm app -- ${getExe config.programs.librewolf.package}"
      ];
      exec-once = optionals cfg.autostart [
        "[workspace ${toString cfg.workspace} silent] uwsm app -- ${getExe config.programs.librewolf.package}"
      ];
      windowrule = [
        "idleinhibit fullscreen, class:librewolf, title:(Youtube)"
        "float, class:librewolf, title:^Extension: \(NoScript\) - NoScript"
        #FIXME initial title is librewolf
        #TODO no fullscreen
      ];
    };
    programs.niri.settings = {
      binds."Mod+Alt+W" = mkIf cfg.setAsDefaultBrowser {
        action.spawn-sh = "uwsm app -- ${getExe config.programs.librewolf.package}";
      };
      spawn-at-startup = optionals cfg.autostart [
        { sh = "uwsm app -- ${getExe config.programs.librewolf.package}"; }
      ];
      window-rules = [
        {
          matches = [
            {
              app-id = "librewolf";
              title = "^Extension: \(NoScript\) - NoScript";
            }
          ];
          open-floating = true;
        }
      ];
    };
  };
}
