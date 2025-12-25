{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib;
let
  cfg = config.dafitt.desktopEnvironment-hyprland.plugins.hyprtrails;
in
{
  imports = with inputs; [
    self.homeModules.stylix
  ];

  options.dafitt.desktopEnvironment-hyprland.plugins.hyprtrails = {
    enable = mkEnableOption "hyprtrails";
  };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      # https://github.com/hyprwm/hyprland-plugins/tree/main/hyprtrails
      plugins = [ pkgs.hyprlandPlugins.hyprtrails ];

      extraConfig = ''
        plugin:hyprtrails {
          color = rgba(${config.lib.stylix.colors.base0A}ff)
        }
      '';
    };
  };
}
