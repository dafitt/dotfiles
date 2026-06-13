{
  config,
  lib,
  pkgs,
  osConfig ? { },
  ...
}:
with lib;
let
  cfg = config.dafitt.MODULE;
in
{
  #meta.doc = builtins.toFile "doc.md" "A module that does something.";

  options.dafitt.MODULE = with types; {
    setAsDefault = mkEnableOption "making it the default";

    autostart = mkEnableOption "autostart at user login";

    workspace = mkOption {
      type = int;
      default = 5;
      description = "Which workspace is mainly to be used for this application.";
    };
  };

  config = {
    home.packages = with pkgs; [ MODULE ];

    programs.MODULE.enable = true;

    wayland.windowManager.hyprland.settings = {
      bind = optionals cfg.setAsDefault [
        {
          _args = [
            "SUPER + ALT + ?"
            (mkLuaInline ''hl.dsp.exec_cmd("uwsm app -- ${getExe pkgs.MODULE}")'')
            { description = "Open MODULE"; }
          ];
        }
      ];
      exec-once = optionals cfg.autostart [
        {
          _args = [
            "hyprland.start"
            (mkLuaInline ''function() hl.exec_cmd("uwsm app -- ${getExe pkgs.MODULE}", { workspace = "${toString cfg.workspace} silent" }) end'')
          ];
        }
      ];
      window_rule = [
        {
          match.class = "^$";
          match.title = "^$";
          float = true;
          no_screen_share = true;
        }
      ];
    };
    programs.niri.settings = {
      binds."Mod+Alt+?" = mkIf cfg.setAsDefault {
        action.spawn-sh = "uwsm app -- ${getExe pkgs.MODULE}";
      };
      spawn-at-startup = optionals cfg.autostart [
        { sh = "uwsm app -- ${getExe pkgs.MODULE}"; }
      ];
    };
    programs.niri.settings = {
      # https://yalter.github.io/niri/Configuration%3A-Window-Rules.html
      #$ niri msg pick-window
      window-rules = [
        {
          matches = [ { app-id = "$"; } ];
          open-floating = true;
          block-out-from = "screen-capture";
        }
      ];
    };
  };
}
