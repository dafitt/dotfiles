{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.hyprland.themes.custom2023.notifications.hyprnotify;
  hyprlandCfg = config.wayland.windowManager.hyprland;
in
{
  options.dafitt.hyprland.themes.custom2023.notifications.hyprnotify = with types; {
    enable = mkEnableOption "hyprnotify for hyprland";
  };

  config = mkIf cfg.enable {
    systemd.user.services.hyprnotify = {
      Unit = {
        Description = "DBus Implementation for 'hyprctl notify'";
        PartOf = [ "wayland-session@Hyprland.target" ];
        After = [ "wayland-session@Hyprland.target" ];
        ConditionEnvironment = "WAYLAND_DISPLAY";
      };
      Service = {
        ExecStart = "${pkgs.hyprnotify}/bin/hyprnotify";
      };
      Install.WantedBy = [ "wayland-session@Hyprland.target" ];
    };
  };
}
