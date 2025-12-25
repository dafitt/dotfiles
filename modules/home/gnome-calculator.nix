{ pkgs, ... }:
{
  home.packages = with pkgs; [ gnome-calculator ];

  wayland.windowManager.hyprland.settings = {
    bind = [ ", XF86Calculator, exec, uwsm app -- ${pkgs.gnome-calculator}/bin/gnome-calculator" ];
    windowrule = [
      "float, class:org.gnome.Calculator, title:Calculator"
      "keepaspectratio, class:org.gnome.Calculator, title:Calculator"
    ];
  };
}
