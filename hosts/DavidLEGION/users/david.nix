{ inputs, ... }:

#> perSystem.self.homeConfigurations."david@DavidLEGION"
{
  home.stateVersion = "23.11";

  imports =
    with inputs;
    with inputs.self.homeModules;
    [
      imports
      SHARED
      bluetooth
      development
      fileManager-yazi
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

  programs.niri.settings.outputs."eDP-2" = {
    mode = {
      width = 2560;
      height = 1600;
      refresh = 165.;
    };
    scale = 1.25;
    variable-refresh-rate = true;
  };
}
