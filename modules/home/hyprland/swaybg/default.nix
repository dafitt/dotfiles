{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.hyprland.swaybg;
in
{
  options.dafitt.hyprland.swaybg = with types; {
    enable = mkBoolOpt false "Whether to enable swaybg for hyprland.";
  };

  config = mkIf cfg.enable {
    # wallpaper utility for Wayland compositors
    # https://github.com/swaywm/swaybg
    home.packages = with pkgs; [ swaybg ];

    wayland.windowManager.hyprland.settings = {
      exec-once = [
        "${pkgs.swaybg}/bin/swaybg --mode fill --image ${config.stylix.image}" # start background service
      ];
      exec = [
        ""
      ];
    };
  };
}
