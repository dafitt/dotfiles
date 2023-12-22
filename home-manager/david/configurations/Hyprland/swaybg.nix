{ pkgs, config, ... }: {

  # wallpaper utility for Wayland compositors
  # https://github.com/swaywm/swaybg
  home.packages = [ pkgs.swaybg ];

  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "${pkgs.swaybg}/bin/swaybg --mode fill --image ${config.stylix.image}" # start background service
    ];
    exec = [
      ""
    ];
  };
}
