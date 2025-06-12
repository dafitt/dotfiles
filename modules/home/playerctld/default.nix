{ config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.playerctld;
in
{
  options.dafitt.playerctld = with types; {
    enable = mkEnableOption "playerctld";
  };

  config = mkIf cfg.enable {
    # playerctl (media control) daemon
    services.playerctld.enable = true;

    wayland.windowManager.hyprland.settings = {
      bind = [
        ", XF86AudioPlay, exec, ${config.services.playerctld.package}/bin/playerctl play-pause"
        ", XF86AudioPause, exec, ${config.services.playerctld.package}/bin/playerctl play-pause"
        ", XF86AudioStop, exec, ${config.services.playerctld.package}/bin/playerctl stop"
        ", XF86AudioNext, exec, ${config.services.playerctld.package}/bin/playerctl next"
        ", XF86AudioPrev, exec, ${config.services.playerctld.package}/bin/playerctl previous"
        "CTRL, XF86AudioRaiseVolume, exec, ${config.services.playerctld.package}/bin/playerctl position 1+"
        "CTRL, XF86AudioLowerVolume, exec, ${config.services.playerctld.package}/bin/playerctl position 1-"
        "ALT, XF86AudioNext, exec, ${config.services.playerctld.package}/bin/playerctld shift"
        "ALT, XF86AudioPrev, exec, ${config.services.playerctld.package}/bin/playerctld unshift"
        "ALT, XF86AudioPlay, exec, systemctl --user restart playerctld"
      ];
    };
  };
}
