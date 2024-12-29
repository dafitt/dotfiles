{ options, config, lib, pkgs, inputs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.hyprland.themes.custom2023;
  hyprlandCfg = config.wayland.windowManager.hyprland;
in
{
  options.dafitt.hyprland.themes.custom2023 = with types; {
    enable = mkEnableOption "the custom2023 theme";
  };

  config = mkIf cfg.enable {
    dafitt.hyprland.themes.custom2023 = {
      notifications.mako.enable = true;
      swayosd.enable = true;
      waybar.enable = true;
    };
  };
}
