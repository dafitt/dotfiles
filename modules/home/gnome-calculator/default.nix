{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.gnome-calculator;
in
{
  options.dafitt.gnome-calculator = with types; {
    enable = mkEnableOption "gnome-calculator";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ gnome-calculator ];

    wayland.windowManager.hyprland.settings = {
      bind = [ ", XF86Calculator, exec, uwsm app -- ${pkgs.gnome-calculator}/bin/gnome-calculator" ];
      windowrule = [
        "float, class:org.gnome.Calculator, title:Calculator"
        "keepaspectratio, class:org.gnome.Calculator, title:Calculator"
      ];
    };
  };
}
