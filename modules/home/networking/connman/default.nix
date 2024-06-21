{ options, config, lib, pkgs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.networking.connman;
  osCfg = osConfig.dafitt.networking.connman or null;
in
{
  options.dafitt.networking.connman = with types;{
    enable = mkBoolOpt (osCfg.enable or false) "Enable a gui for connman.";
  };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland.settings = {
      bind = optionals config.dafitt.desktops.hyprland.pyprland.enable
        [ "SUPER_ALT, N, exec, ${pkgs.pyprland}/bin/pypr toggle connman" ];
      windowrulev2 = [ "float, class:connman-gtk" ];
    };

    dafitt.desktops.hyprland.pyprland.scratchpads.connman = {
      animation = "fromRight";
      command = "${pkgs.connman-gtk}/bin/connman-gtk";
      class = "connman-gtk";
      size = "40% 70%";
      margin = "2%";
      lazy = true;
    };
  };
}
