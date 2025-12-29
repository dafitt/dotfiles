{ lib, pkgs, ... }:
with lib;
{
  home.packages = with pkgs; [ gnome-calculator ];

  wayland.windowManager.hyprland.settings = {
    bind = [ ", XF86Calculator, exec, uwsm app -- ${getExe pkgs.gnome-calculator}" ];
    windowrule = [
      "float, class:org.gnome.Calculator, title:Calculator"
      "keepaspectratio, class:org.gnome.Calculator, title:Calculator"
    ];
  };
  programs.niri.settings = {
    binds."XF86Calculator" = {
      action.spawn-sh = "uwsm app -- ${getExe pkgs.gnome-calculator}";
    };
    window-rules = [
      {
        matches = [ { app-id = "org.gnome.Calculator"; } ];
        open-floating = true;
      }
    ];
  };
}
