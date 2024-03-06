{ config, lib, options, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.desktops.hyprland.plugins;
in
{
  options.custom.desktops.hyprland.plugins = with types; {
    enable = mkBoolOpt config.custom.desktops.hyprland.enable "Enable plugins for hyprland";
  };

  config = mkIf cfg.enable {
    # <https://github.com/hyprwm/hyprland-plugins/tree/main>
    wayland.windowManager.hyprland = {

      plugins = [
        #inputs.hyprland-plugins.packages.${pkgs.system}.hyprwinwrap # allows you to put any app as a wallpaper
        #inputs.hyprland-plugins.packages.${pkgs.system}.hyprtrails
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
  };
}
