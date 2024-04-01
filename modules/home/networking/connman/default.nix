{ options, config, lib, pkgs, osConfig ? { }, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.networking.connman;
  osCfg = osConfig.custom.networking.connman or null;
in
{
  options.custom.networking.connman = with types;{
    enable = mkBoolOpt (osCfg.enable or false) "Enable a gui for connman";
  };

  config = mkIf cfg.enable {
    # GTK GUI for Connman
    home.packages = with pkgs; [
      connman-gtk
      connman-ncurses
      connman-notify
    ];

    wayland.windowManager.hyprland.settings = {
      bind = [ "SUPER_ALT, N, exec, ${pkgs.connman-gtk}/bin/connman-gtk" ];
      windowrulev2 = [ "float, class:connman-gtk" ];
    };
  };
}
