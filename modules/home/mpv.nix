{
  # https://mpv.io/
  programs.mpv.enable = true;

  wayland.windowManager.hyprland.settings = {
    windowrule = [
      "match:class mpv$, idle_inhibit focus"
    ];
  };
}
