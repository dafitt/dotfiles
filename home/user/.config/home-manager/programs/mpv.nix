{
  # a free, open source, and cross-platform media player
  # https://mpv.io/
  programs.mpv = {
    enable = true;
    #defaultProfiles = [ "gpu-hq" ];
    #scripts = [ pkgs.mpvScripts.mpris ];
  };

  wayland.windowManager.hyprland.settings = {
    windowrulev2 = [
      "idleinhibit focus, class:mpv" # 
    ];
  };
}
