{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.hyprland.plugins.hyprwinwrap;
in
{
  options.dafitt.hyprland.plugins.hyprwinwrap = with types; {
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
