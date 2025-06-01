{ config, lib, pkgs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.networking.networkmanager;
  osCfg = osConfig.dafitt.networking.networkmanager or null;
in
{
  options.dafitt.networking.networkmanager = with types;{
    enable = mkBoolOpt (osCfg.enable or false) "Whether to enable a gui for networkmanager.";
  };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland.settings = {
      bind = optionals config.dafitt.hyprland.pyprland.enable
        [ "SUPER_ALT, N, exec, ${pkgs.pyprland}/bin/pypr toggle networkmanager" ];
      windowrule = [ "float, class:nm-connection-editor" ];
    };

    dafitt.hyprland.pyprland.scratchpads.networkmanager = {
      animation = "fromRight";
      command = "uwsm app -- ${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
      class = "nm-connection-editor";
      size = "40% 70%";
      margin = "2%";
      lazy = true;
    };
  };
}
