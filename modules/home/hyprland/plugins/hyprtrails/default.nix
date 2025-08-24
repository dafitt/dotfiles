{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.hyprland.plugins.hyprtrails;
in
{
  options.dafitt.hyprland.plugins.hyprtrails = with types; {
    enable = mkEnableOption "hyprtrails";
  };

  config = mkIf cfg.enable {
    dafitt.stylix.enable = true;

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
