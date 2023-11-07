{ config, lib, pkgs, ... }: {

  # Desktop Publishing (DTP) and Layout program for Linux
  # 
  home.packages = [
    #scribus
  ];

  wayland.windowManager.hyprland.settings = {
    bind = [ ];
    exec-once = [ ];
    exec = [ ];
    windowrulev2 = [
      "float, class:scribus, title:(New Document)"
    ];
  };
}
