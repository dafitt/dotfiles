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
          match.class = "MODULE$";
          match.title = "MODULE$";
          float = true;
          no_screen_share = true;
        }
      ];
    };
    programs.umbriel.settings = {
      keybinds."Mod+Alt+?" = mkIf cfg.setAsDefault {
        action = "spawn:${getExe pkgs.MODULE}";
        repeat = false;
      };
      general.autostart = optionals cfg.autostart [ (getExe pkgs.MODULE) ];
      window_rule = [
        {
          match.app_id = "MODULE$";
          default_floating = true;
        }
      ];
    };
  };
}
