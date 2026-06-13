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
  #meta.doc = builtins.toFile "doc.md" ''
  #  Installs and configures the LibreWolf web browser.
  #  https://librewolf.net/
  #'';

  options.dafitt.browser-librewolf = with types; {
    setAsDefaultBrowser = mkEnableOption "making it the default web browser";

    autostart = mkEnableOption "autostart at user login";

    workspace = mkOption {
      type = int;
      default = 1;
      description = "Which workspace is mainly to be used for this application.";
    };
  };

  config = {
    programs.librewolf = {
      enable = true;
      settings = config.programs.firefox.profiles.${config.home.username}.settings // { };
    };

    wayland.windowManager.hyprland.settings = {
      bind = optionals cfg.setAsDefaultBrowser [
        {
          _args = [
            "SUPER + ALT + W"
            (mkLuaInline ''hl.dsp.exec_cmd("uwsm app -- ${getExe config.programs.librewolf.package}")'')
            { description = "Open browser"; }
          ];
        }
      ];
      on = optionals cfg.autostart [
        {
          _args = [
            "hyprland.start"
            (mkLuaInline ''function() hl.exec_cmd("uwsm app -- ${getExe config.programs.librewolf.package}", { workspace = "${toString cfg.workspace} silent" }) end'')
          ];
        }
      ];
      window_rule = [
        {
          match.class = "librewolf";
          match.title = "Youtube";
          idle_inhibit = "fullscreen";
        }
        {
          match.class = "librewolf";
          match.title = "^Extension: \(NoScript\) - NoScript";
          float = true;
        }
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
