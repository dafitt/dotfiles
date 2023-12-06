{ config, lib, pkgs, ... }: {

  # 
  # 
  home.packages = [ ];

  dconf.settings = { };

  wayland.windowManager.hyprland.settings = {
    bind = [ ];
    exec-once = [ ];
    exec = [ ];
    windowrulev2 = [ ];
  };
}
