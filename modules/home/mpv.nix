{
  # https://mpv.io/
  programs.mpv.enable = true;

  wayland.windowManager.hyprland.settings = {
    windowrule = [
      "idleinhibit focus, class:mpv"
    ];
  };
}
