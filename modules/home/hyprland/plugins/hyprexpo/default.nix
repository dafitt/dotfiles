{ config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.hyprland.plugins.hyprexpo;
in
{
  options.dafitt.hyprland.plugins.hyprexpo = with types; {
    enable = mkEnableOption "hyprexpo";
  };

  config = mkIf cfg.enable {
    dafitt.stylix.enable = true;

    wayland.windowManager.hyprland = {
      # https://github.com/hyprwm/hyprland-plugins/tree/main/hyprexpo
      plugins = [ pkgs.hyprlandPlugins.hyprexpo ];

      settings.bind = [ "SUPER, ASCIICIRCUM, hyprexpo:expo, toggle" ]; # can be: toggle, off/disable or on/enable

      # https://github.com/hyprwm/hyprland-plugins/tree/main/hyprexpo#config
      extraConfig = ''
        plugin:hyprexpo {
          workspace_method = first 1
          gesture_positive = true
          gap_size = ${toString config.wayland.windowManager.hyprland.settings.general.gaps_in}
          bg_col = rgb(${config.lib.stylix.colors.base04})
        }
      '';
    };
  };
}
