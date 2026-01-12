{ pkgs, ... }:
{
  home.packages = with pkgs; [
    quickemu
    quickgui
  ];

  wayland.windowManager.hyprland.settings = {
    windowrule = [
      "match:class quickgui$, float on"
    ];
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
