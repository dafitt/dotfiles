{ pkgs, ... }:
{
  home.packages = with pkgs; [
    quickemu
    quickgui
  ];

  wayland.windowManager.hyprland.settings = {
    window_rule = [
      {
        match.class = "quickgui$";
        float = true;
      }
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
  programs.umbriel.settings = {
    window_rule = [
      {
        match.app_id = "quickgui";
        default_floating = true;
      }
    ];
  };
}
