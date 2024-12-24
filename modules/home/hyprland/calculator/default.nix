{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.hyprland.calculator;
in
{
  options.dafitt.hyprland.calculator = with types; {
    enable = mkBoolOpt false "Whether to enable a calculator for hyprland.";
  };

  config = mkIf cfg.enable {

    home.packages = with pkgs; [ gnome-calculator ];

    wayland.windowManager.hyprland.settings = {
      bind = [ ", XF86Calculator, exec, ${pkgs.gnome-calculator}/bin/gnome-calculator" ];
      windowrulev2 = [
        "float, class:org.gnome.Calculator, title:Calculator"
        "keepaspectratio, class:org.gnome.Calculator, title:Calculator"
      ];
    };
  };
}
