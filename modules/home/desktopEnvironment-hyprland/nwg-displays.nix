{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    wlr-randr
    nwg-displays
  ];

  home.activation = {
    touchNwgdisplayFiles = config.lib.dag.entryAfter [ "writeBoundary" ] ''
      touch -a $HOME/.config/hypr/monitors.lua
      touch -a $HOME/.config/hypr/workspaces.lua
    '';
  };

  wayland.windowManager.hyprland.extraConfig = ''
    require("monitors")
    require("workspaces")
  '';
}
