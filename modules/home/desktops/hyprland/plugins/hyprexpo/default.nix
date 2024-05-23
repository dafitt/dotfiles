{ options, config, lib, pkgs, inputs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.desktops.hyprland.plugins.hyprexpo;
in
{
  options.dafitt.desktops.hyprland.plugins.hyprexpo = with types; {
    enable = mkBoolOpt false "Enable hyprexpo hyprland plugin";
  };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      # https://github.com/hyprwm/hyprland-plugins/tree/main/hyprexpo
      plugins = with pkgs; [ inputs.hyprland-plugins.packages.${system}.hyprexpo ];

      settings.bind = [ "SUPER, grave, hyprexpo:expo, toggle" ]; # can be: toggle, off/disable or on/enable

      extraConfig = ''
        plugin {
          hyprexpo {
            columns = 3
            gap_size = 5
            bg_col = rgb(111111)
            workspace_method = center current # [center/first] [workspace] e.g. first 1 or center m+1

            enable_gesture = true # laptop touchpad, 4 fingers
            gesture_distance = 300 # how far is the "max"
            gesture_positive = true # positive = swipe down. Negative = swipe up.
          }
        }
      '';
    };
  };
}
