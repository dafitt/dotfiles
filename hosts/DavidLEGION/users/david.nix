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

  programs.noctalia-shell.settings.desktopWidgets = {
    enabled = true;
    gridSnap = true;
    monitorWidgets = [
      {
        name = "eDP-2";
        widgets = [
          {
            clockStyle = "minimal";
            customFont = "Unifont";
            format = "yyyy-MM-dd T HH:mm";
            id = "Clock";
            roundedCorners = false;
            scale = 3.121209858125082;
            showBackground = false;
            useCustomFont = true;
            usePrimaryColor = true;
            x = 60;
            y = 1320;
          }
        ];
      }
    ];
  };
}
