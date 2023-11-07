{ config, lib, pkgs, ... }: {

  # GTK GUI for Connman
  # 
  home.packages = with pkgs; [
    connman-gtk
    connman-ncurses
    connman-notify
  ];

  wayland.windowManager.hyprland.settings = {
    bind = [ "ALT SUPER, N, exec, ${pkgs.connman-gtk}/bin/connman-gtk" ];
    exec-once = [ ];
    exec = [ ];
    windowrulev2 = [ "float, class:connman-gtk" ];
  };
}
