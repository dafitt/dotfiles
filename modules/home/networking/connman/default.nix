{ config, lib, pkgs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.networking.connman;
  osCfg = osConfig.dafitt.networking.connman or null;
in
{
  options.dafitt.networking.connman = with types;{
    enable = mkBoolOpt (osCfg.enable or false) "Whether to enable a gui for connman.";
  };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland.settings = {
      bind = optionals config.dafitt.hyprland.pyprland.enable
        [ "SUPER_ALT, N, exec, ${pkgs.pyprland}/bin/pypr toggle connman" ];
      windowrule = [ "float, class:connman-gtk" ];
    };

    dafitt.hyprland.pyprland.scratchpads.connman = {
      animation = "fromRight";
      command = "uwsm app -- ${pkgs.connman-gtk}/bin/connman-gtk";
      class = "connman-gtk";
      size = "40% 70%";
      margin = "2%";
      lazy = true;
    };
  };
}
