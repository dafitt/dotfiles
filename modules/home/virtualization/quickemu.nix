{ pkgs, ... }:
{
  home.packages = with pkgs; [
    quickemu
    quickgui
  ];

  wayland.windowManager.hyprland.settings = {
    windowrule = [ "float, class:quickgui" ];
  };
  programs.niri.settings = {
    window-rules = [
      {
        matches = [ { app-id = "quickgui"; } ];
        open-floating = true;
      }
    ];
  };
}
