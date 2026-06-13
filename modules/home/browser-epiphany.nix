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
  #meta.doc = builtins.toFile "doc.md" "Installs and configures the Epiphany web browser.";

  options.dafitt.browser-epiphany = with types; {
    setAsDefaultBrowser = mkEnableOption "making it the default web browser";

    autostart = mkEnableOption "autostart at user login";

    workspace = mkOption {
      type = int;
      default = 1;
      description = "Which workspace is mainly to be used for this application.";
    };
  };

  config = {
    home.packages = with pkgs; [ epiphany ];

    wayland.windowManager.hyprland.settings = {
      bind = optionals cfg.setAsDefaultBrowser [
        {
          _args = [
            "SUPER + ALT + W"
            (mkLuaInline ''hl.dsp.exec_cmd("uwsm app -- ${getExe pkgs.epiphany}")'')
            { description = "Open browser"; }
          ];
        }
      ];
      on = optionals cfg.autostart [
        {
          _args = [
            "hyprland.start"
            (mkLuaInline ''function() hl.exec_cmd("uwsm app -- ${getExe pkgs.epiphany}", { workspace = "${toString cfg.workspace} silent" }) end'')
          ];
        }
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
