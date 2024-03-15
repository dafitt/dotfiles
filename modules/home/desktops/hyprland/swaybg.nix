{ options, config, lib, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.desktops.hyprland.swaybg;
in
{
  options.custom.desktops.hyprland.swaybg = with types; {
    enable = mkBoolOpt config.custom.desktops.hyprland.enable "Enable swaybg for hyprland";
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
