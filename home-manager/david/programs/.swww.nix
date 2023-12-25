{ pkgs, config, ... }: {

  # A Solution to your Wayland Wallpaper Woes
  # https://github.com/Horus645/swww
  home.packages = [ pkgs.swww ];

  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "${pkgs.swww}/bin/swww init && sleep 2 && ${pkgs.swww}/bin/swww img ${config.stylix.image}" # start background service
    ];
    exec = [
      "${pkgs.swww}/bin/swww img ${config.stylix.image} #? (optional animations) --transition-step 10 --transition-fps 120 --transition-type grow --transition-pos 0.5,0.5 --transition-duration 1"
    ];
  };
}
