{ config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.pavucontrol;
in
{
  options.dafitt.pavucontrol = with types; {
    enable = mkEnableOption "the pavucontrol, PulseAudio Volume Control";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ pavucontrol ];

    wayland.windowManager.hyprland.settings = {
      bind = optionals config.dafitt.hyprland.pyprland.enable
        [ "SUPER_ALT, A, exec, ${pkgs.pyprland}/bin/pypr toggle pavucontrol" ];
      windowrule = [
        "float, class:pavucontrol, title:^(Volume Control)$"
        "center, class:pavucontrol, title:^(Volume Control)$"
        #"size 800 600, class:pavucontrol, title:^(Volume Control)$"
      ];
    };

    dafitt.hyprland.pyprland.scratchpads.pavucontrol = {
      animation = "fromRight";
      command = "uwsm app -- ${pkgs.pavucontrol}/bin/pavucontrol";
      class = "pavucontrol";
      size = "40% 70%";
      margin = "2%";
      unfocus = "hide";
      lazy = true;
    };
  };
}
