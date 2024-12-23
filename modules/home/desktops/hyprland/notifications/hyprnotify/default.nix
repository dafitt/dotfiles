{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.desktops.hyprland.notifications.hyprnotify;
  hyprlandCfg = config.wayland.windowManager.hyprland;
in
{
  options.dafitt.desktops.hyprland.notifications.hyprnotify = with types; {
    enable = mkBoolOpt config.dafitt.desktops.hyprland.enable "Whether to enable hyprnotify for hyprland.";
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
