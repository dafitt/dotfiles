{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dafitt.desktopEnvironment-hyprland.plugins.hypr-darkwindow;
in
{
  options.dafitt.desktopEnvironment-hyprland.plugins.hypr-darkwindow = {
    enable = mkEnableOption "hypr-darkwindow";
  };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      # https://github.com/micha4w/Hypr-DarkWindow
      plugins = [ pkgs.hyprlandPlugins.hypr-darkwindow ];

      settings.bind = [
        {
          _args = [
            "SUPER + O"
            (mkLuaInline ''hl.plugin.darkwindow.dsp_shade({shader = "invert"})'')
            { description = "Invert the active window's colors (light/dark)"; }
          ];
        }
      ];
    };
  };
}
