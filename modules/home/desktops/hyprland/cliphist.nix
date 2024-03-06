{ config, lib, options, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.desktops.hyprland.cliphist;
in
{
  options.custom.desktops.hyprland.cliphist = with types; {
    enable = mkBoolOpt config.custom.desktops.hyprland.enable "Enable cliphist for hyprland";
  };

  config = mkIf cfg.enable {
    # Wayland clipboard manager
    # https://github.com/sentriz/cliphist
    services.cliphist = {
      enable = true;
      #systemdTarget =
    };

    home.packages = [
      pkgs.wl-clipboard # Command-line copy/paste utilities for Wayland
    ];

    wayland.windowManager.hyprland.settings = {
      bind = [
        "ALT SUPER, V, exec, ${pkgs.kitty}/bin/kitty --class=clipboard -e sh -c 'cliphist list | fzf | cliphist decode | wl-copy'"
      ];
      exec-once = [
        "${pkgs.wl-clipboard}/bin/wl-paste --type text --watch cliphist store --max-items 10" # listen for clipboard changes on your keyboard and write it to the history
        "${pkgs.wl-clipboard}/bin/wl-paste --type image --watch cliphist store --max-items 10" # listen for clipboard changes on your keyboard and write it to the history
      ];
      windowrulev2 = [
        "float, class:clipboard"
        "size 640 360, class:clipboard"
        "center, class:clipboard"
      ];
    };
  };
}
