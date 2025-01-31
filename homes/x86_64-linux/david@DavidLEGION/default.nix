#nix-repl> nixosConfigurations.DavidLEGION.config.snowfallorg.users.david.home.config

{ config, lib, pkgs, inputs, ... }:

with lib;
with lib.dafitt; {
  imports = with inputs; [
    ../../user-configurations/david.nix
  ];

  dafitt = {
    filemanagers.yazi.enable = true;
    hyprland.monitors = [{ name = "eDP-2"; primary = true; width = 1920; height = 1200; refreshRate = 165; vrr = 1; workspace = "1"; }];
    latex.enable = false;
    launchers.rofi.enable = true;
    steam.enable = true;
    suiteOffice.enable = true;
    suiteSocial.enable = true;
  };

  # [Hyprland - Tearing](https://wiki.hyprland.org/Configuring/Tearing/)
  wayland.windowManager.hyprland.settings.general.allow_tearing = true;
  wayland.windowManager.hyprland.settings.env = [ "WLR_DRM_NO_ATOMIC,1" ]; # because of amd gpu

  # MultiGPU
  #wayland.windowManager.hyprland.settings.env = [ "WLR_DRM_DEVICES,/dev/dri/card1:/dev/dri/card0" ];
}
