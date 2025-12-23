#nix-repl> nixosConfigurations.DavidLEGION.config.snowfallorg.users.david.home.config

{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

with lib;
with lib.dafitt;
{
  imports = with inputs; [
    ../../user-configurations/david.nix
  ];

  dafitt = {
    hyprland.nwg-displays.enable = true;
    latex.enable = false;
    rofi.enable = true;
    steam.enable = true;
    suiteOffice.enable = true;
    suiteSocial.enable = true;
    yazi.enable = true;
  };

  wayland.windowManager.hyprland.settings.input.sensitivity = 0.1;

  # [Hyprland - Tearing](https://wiki.hypr.land/Configuring/Tearing/)
  wayland.windowManager.hyprland.settings.general.allow_tearing = true;
  wayland.windowManager.hyprland.settings.env = [ "WLR_DRM_NO_ATOMIC,1" ]; # because of amd gpu

  # MultiGPU
  #wayland.windowManager.hyprland.settings.env = [ "WLR_DRM_DEVICES,/dev/dri/card1:/dev/dri/card0" ];
}
