{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.desktops.hyprland.calculator;
in
{
  options.dafitt.desktops.hyprland.calculator = with types; {
    enable = mkBoolOpt config.dafitt.desktops.hyprland.enable "Enable a calculator for hyprland.";
  };

  config = mkIf cfg.enable {

    home.packages = with pkgs; [ gnome.gnome-calculator ];

    wayland.windowManager.hyprland.settings = {
      bind = [ ", XF86Calculator, exec, ${pkgs.gnome.gnome-calculator}/bin/gnome-calculator" ];
      windowrulev2 = [
        "float, class:org.gnome.Calculator, title:Calculator"
        "keepaspectratio, class:org.gnome.Calculator, title:Calculator"
      ];
    };
  };
}
