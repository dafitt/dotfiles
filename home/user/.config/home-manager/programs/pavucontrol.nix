{ config, lib, pkgs, ... }: {

  # PulseAudio Volume Control
  home.packages = [ pkgs.pavucontrol ];

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
}
