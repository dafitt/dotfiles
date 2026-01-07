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
        "Super&Alt, ?, exec, uwsm app -- ${getExe pkgs.MODULE}"
      ];
      exec-once = optionals cfg.autostart [
        "[workspace ${toString cfg.workspace} silent] ${getExe pkgs.MODULE}"
      ];
      windowrule = [
        "class:$, title:^, float"
        "class:$, title:^, no_screen_share"
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
