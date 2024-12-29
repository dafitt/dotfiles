{ options, config, lib, pkgs, ... }:

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

      settings.bind = [ "SUPER, acute, hyprexpo:expo, toggle" ]; # can be: toggle, off/disable or on/enable

      extraConfig = ''
        plugin:hyprexpo {
          columns = 3
          gap_size = ${toString config.wayland.windowManager.hyprland.settings.general.gaps_in}
          bg_col = rgb(${config.lib.stylix.colors.base04})
          workspace_method = center current # [center/first] [workspace] e.g. first 1 or center m+1

          enable_gesture = true # laptop touchpad, 4 fingers
          gesture_distance = 300 # how far is the "max"
          gesture_positive = false # positive = swipe down. Negative = swipe up.
        }
      '';
    };
  };
}
