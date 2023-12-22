{ config, lib, pkgs, ... }: {

  # Wayland clipboard manager
  # https://github.com/sentriz/cliphist
  services.clipman = {
    enable = true;
    package = pkgs.cliphist;
  };

  home.packages = [
    pkgs.wl-clipboard # Command-line copy/paste utilities for Wayland
  ];

  wayland.windowManager.hyprland.settings = {
    bind = [
      "ALT SUPER, V, exec, $TERMINAL -e sh -c 'cliphist list | fzf | cliphist decode | wl-copy'" # TODO clipboard picker
    ];
    exec-once = [
      "${pkgs.wl-clipboard}/bin/wl-paste --type text --watch cliphist store --max-items 10" # listen for clipboard changes on your keyboard and write it to the history
      "${pkgs.wl-clipboard}/bin/wl-paste --type image --watch cliphist store --max-items 10" # listen for clipboard changes on your keyboard and write it to the history
    ];
  };
}