{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.desktops.hyprland.plugins.hyprwinwrap;
in
{
  options.dafitt.desktops.hyprland.plugins.hyprwinwrap = with types; {
    enable = mkBoolOpt false "Enable the hyprwinwrap hyprland plugin.";
  };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      # https://github.com/hyprwm/hyprland-plugins/tree/main/hyprwinwrap
      plugins = with pkgs; [ hyprlandPlugins.hyprwinwrap ];

      extraConfig = ''
        plugin:hyprwinwrap {
          class = wallpaper
        }
      '';
    };
  };
}
