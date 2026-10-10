{
  config,
  lib,
  pkgs,
  osConfig ? { },
  ...
}:
with lib;
let
  cfg = config.dafitt.obidian;

  pkg = config.programs.obsidian.package;
in
{
  options.dafitt.obidian = with types; {
    setAsDefault = mkEnableOption "making it the default";

    autostart = mkEnableOption "autostart at user login";

    workspace = mkOption {
      type = int;
      default = 5;
      description = "Which workspace is mainly to be used for this application.";
    };
  };

  config = {
    # programs.obsidian.enable = true;
    home.packages = with pkgs; [ obsidian ];

    wayland.windowManager.hyprland.settings = {
      bind = optionals cfg.setAsDefault [
        {
          _args = [
            "SUPER + ALT + H"
            (mkLuaInline ''hl.dsp.exec_cmd("uwsm app -- ${getExe pkg}")'')
            { description = "Open obidian"; }
          ];
        }
      ];
      exec-once = optionals cfg.autostart [
        {
          _args = [
            "hyprland.start"
            (mkLuaInline ''function() hl.exec_cmd("uwsm app -- ${getExe pkg}", { workspace = "${toString cfg.workspace} silent" }) end'')
          ];
        }
      ];
    };
    programs.niri.settings = {
      binds."Mod+Alt+H" = mkIf cfg.setAsDefault {
        action.spawn-sh = "uwsm app -- ${getExe pkg}";
      };
      spawn-at-startup = optionals cfg.autostart [
        { sh = "uwsm app -- ${getExe pkg}"; }
      ];
    };
    programs.umbriel.settings = {
      keybinds."Mod+Alt+H" = mkIf cfg.setAsDefault {
        action = "spawn:" + (getExe pkg);
        repeat = false;
      };
      general.autostart = optionals cfg.autostart [ (getExe pkg) ];
    };
  };
}
