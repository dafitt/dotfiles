{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.hyprland.notifications.hyprnotify;
  hyprlandCfg = config.wayland.windowManager.hyprland;

  isDefault = config.dafitt.hyprland.notifications.enable == "hyprnotify";
in
{
  options.dafitt.hyprland.notifications.hyprnotify = with types; {
    enable = mkBoolOpt (isDefault && config.dafitt.hyprland.enable) "Whether to enable hyprnotify for hyprland.";
  };

  config = mkIf cfg.enable {
    systemd.user.services.hyprnotify = {
      Unit = {
        Description = "DBus Implementation for 'hyprctl notify'";
        PartOf = [ "hyprland-session.target" ];
        After = [ "hyprland-session.target" ];
        ConditionEnvironment = "WAYLAND_DISPLAY";
      };
      Service = {
        ExecStart = "${pkgs.hyprnotify}/bin/hyprnotify";
      };
      Install.WantedBy = [ "hyprland-session.target" ];
    };
  };
}
