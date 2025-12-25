{ pkgs, ... }:
{
  home.packages = with pkgs; [
    quickemu
    quickgui
  ];

  wayland.windowManager.hyprland.settings = {
    windowrule = [ "float, class:quickgui" ];
  };
}
