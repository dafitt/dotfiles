{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dafitt.desktopEnvironment-hyprland.plugins.hyprwinwrap;
in
{
  options.dafitt.desktopEnvironment-hyprland.plugins.hyprwinwrap = {
    enable = mkEnableOption "hyprwinwrap";
  };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      # https://github.com/hyprwm/hyprland-plugins/tree/main/hyprwinwrap
      plugins = [ pkgs.hyprlandPlugins.hyprwinwrap ];

      extraConfig = ''
        plugin:hyprwinwrap {
          class = wallpaper
        }
      '';
    };
  };
}
