{ config, pkgs, hyprland-plugins, ... }: {

  # <https://github.com/hyprwm/hyprland-plugins/tree/main>

  wayland.windowManager.hyprland = {

    plugins = [
      #hyprland-plugins.packages.${pkgs.system}.hyprwinwrap # allows you to put any app as a wallpaper
      hyprland-plugins.packages.${pkgs.system}.hyprtrails
    ];

    extraConfig = ''
      plugin {
        hyprwinwrap {
          class = wallpaper
        }
        hyprtrails {
          color = rgba(${config.lib.stylix.colors.base0A}ff)
        }
      }
    '';
  };
}
