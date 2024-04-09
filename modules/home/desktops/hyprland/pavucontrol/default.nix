{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.desktops.hyprland.pavucontrol;
in
{
  options.dafitt.desktops.hyprland.pavucontrol = with types; {
    enable = mkBoolOpt config.dafitt.desktops.hyprland.enable "Enable the pavucontrol, PulseAudio Volume Control";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ pavucontrol ];

    wayland.windowManager.hyprland.settings = {
      bind = [
        "SUPER_ALT, A, exec, ${pkgs.pavucontrol}/bin/pavucontrol"
      ];
      windowrulev2 = [
        "float, class:pavucontrol, title:^(Volume Control)$"
        "center, class:pavucontrol, title:^(Volume Control)$"
        #"size 800 600, class:pavucontrol, title:^(Volume Control)$"
      ];
    };
  };
}
