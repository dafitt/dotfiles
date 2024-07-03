#nix-repl> nixosConfigurations.DavidLEGION.config.snowfallorg.users.david.home.config

{ config, lib, pkgs, inputs, ... }:

with lib;
with lib.dafitt; {
  imports = with inputs; [ ];

  dafitt = {
    desktops.hyprland.monitors = [{
      name = "eDP-2";
      width = 1920; # 16:10
      height = 1200;
      refreshRate = 165;
      workspace = "1";
      primary = true;
    }];

    desktops.hyprland.plugins.enable = false;
    Development.latex.enable = false;
    environment.filemanagers.yazi.enable = true;
    environment.launchers.rofi.enable = true;
    Gaming.steam.enable = true;
    Office.enableSuite = true;
    Social.enableSuite = true;
  };

  # [Hyprland - Tearing](https://wiki.hyprland.org/Configuring/Tearing/)
  wayland.windowManager.hyprland.settings.general.allow_tearing = true;
  wayland.windowManager.hyprland.settings.env = [ "WLR_DRM_NO_ATOMIC,1" ]; # because of amd gpu

  # MultiGPU
  #wayland.windowManager.hyprland.settings.env = [ "WLR_DRM_DEVICES,/dev/dri/card1:/dev/dri/card0" ];
}
