{ config, lib, options, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.desktops.hyprland.calculator;
in
{
  options.custom.desktops.hyprland.calculator = with types; {
    enable = mkBoolOpt config.custom.desktops.hyprland.enable "Enable a calculator for hyprland";
  };

  config = mkIf cfg.enable {

    home.packages = with pkgs; [ gnome.gnome-calculator ];

    wayland.windowManager.hyprland.settings = {
      bind = [ ", XF86Calculator, exec, ${pkgs.gnome.gnome-calculator}/bin/gnome-calculator" ];
      exec-once = [ ];
      exec = [ ];
      windowrulev2 = [
        "float, class:org.gnome.Calculator, title:Calculator"
        "keepaspectratio, class:org.gnome.Calculator, title:Calculator"
      ];
    };
  };
}
