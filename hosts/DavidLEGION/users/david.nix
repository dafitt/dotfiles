{ inputs, ... }:

#> perSystem.self.homeConfigurations."david@DavidLEGION"
{
  home.stateVersion = "23.11";

  imports =
    with inputs;
    with inputs.self.homeModules;
    [
      SHARED
      bluetooth
      development
      fileManager-yazi
      launcher-rofi
      office
      social
      user-david
      web
    ];

  wayland.windowManager.hyprland.settings.input.sensitivity = 0.1;

  # [Hyprland - Tearing](https://wiki.hypr.land/Configuring/Tearing/)
  wayland.windowManager.hyprland.settings.general.allow_tearing = true;
  wayland.windowManager.hyprland.settings.env = [ "WLR_DRM_NO_ATOMIC,1" ]; # because of amd gpu

  # MultiGPU
  #wayland.windowManager.hyprland.settings.env = [ "WLR_DRM_DEVICES,/dev/dri/card1:/dev/dri/card0" ];
}
