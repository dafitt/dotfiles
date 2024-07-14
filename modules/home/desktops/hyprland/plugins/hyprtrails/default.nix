{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.desktops.hyprland.plugins.hyprtrails;
in
{
  options.dafitt.desktops.hyprland.plugins.hyprtrails = with types; {
    enable = mkBoolOpt false "Enable the hyprtrails hyprland plugin.";
  };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      # https://github.com/hyprwm/hyprland-plugins/tree/main/hyprtrails
      plugins = with pkgs; [ hyprlandPlugins.hyprtrails ];

      extraConfig = ''
        plugin:hyprtrails {
          color = rgba(${config.lib.stylix.colors.base0A}ff)
        }
      '';
    };
  };
}
