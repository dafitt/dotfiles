{ options, config, lib, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.desktops.hyprland.pavucontrol;
in
{
  options.custom.desktops.hyprland.pavucontrol = with types; {
    enable = mkBoolOpt config.custom.desktops.hyprland.enable "Enable the pavucontrol, PulseAudio Volume Control";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ pavucontrol ];

    wayland.windowManager.hyprland.settings = {
      bind = [
        "ALT SUPER, A, exec, ${pkgs.pavucontrol}/bin/pavucontrol"
      ];
      exec-once = [ ];
      exec = [ ];
      windowrulev2 = [
        "float, class:pavucontrol, title:^(Volume Control)$"
        "center, class:pavucontrol, title:^(Volume Control)$"
        #"size 800 600, class:pavucontrol, title:^(Volume Control)$"
      ];
    };
  };
}
