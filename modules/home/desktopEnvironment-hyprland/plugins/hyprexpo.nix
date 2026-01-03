{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib;
let
  cfg = config.dafitt.desktopEnvironment-hyprland.plugins.hyprexpo;
in
{
  imports = with inputs; [
    self.homeModules.stylix
  ];

  options.dafitt.desktopEnvironment-hyprland.plugins.hyprexpo = {
    enable = mkEnableOption "hyprexpo";
  };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      # https://github.com/hyprwm/hyprland-plugins/tree/main/hyprexpo
      plugins = [ pkgs.hyprlandPlugins.hyprexpo ];

      settings.bind = [ "Super, ASCIICIRCUM, hyprexpo:expo, toggle" ]; # can be: toggle, off/disable or on/enable

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
