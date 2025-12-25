{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    wlr-randr
    nwg-displays
  ];

  home.activation = {
    touchNwgdisplayFiles = config.lib.dag.entryAfter [ "writeBoundary" ] ''
      touch -a $HOME/.config/hypr/monitors.conf
      touch -a $HOME/.config/hypr/workspaces.conf
    '';
  };

  wayland.windowManager.hyprland.settings = {
    source = [
      "~/.config/hypr/monitors.conf"
      "~/.config/hypr/workspaces.conf"
    ];
  };
}
