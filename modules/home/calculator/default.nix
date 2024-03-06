{ pkgs, ... }: {

  # Calculator
  #
  home.packages = [ pkgs.gnome.gnome-calculator ];

  wayland.windowManager.hyprland.settings = {
    bind = [ ", XF86Calculator, exec, ${pkgs.gnome.gnome-calculator}/bin/gnome-calculator" ];
    exec-once = [ ];
    exec = [ ];
    windowrulev2 = [
      "float, class:org.gnome.Calculator, title:Calculator"
      "keepaspectratio, class:org.gnome.Calculator, title:Calculator"
    ];
  };
}
