{ config, inputs, ... }:

#> perSystem.self.homeConfigurations."david@DavidLEGION"
{
  home.stateVersion = "23.11";
  # default behavior changes
  programs.firefox.configPath = "${config.xdg.configHome}/mozilla/firefox";

  imports = with inputs.self.homeModules; [
    imports
    user-david

    development
    fileManager-yazi
    networking-networkmanager
    office
    social
    web
  ];

  wayland.windowManager.hyprland.settings = {
    monitor = [
      {
        output = "eDP-2";
        mode = "2560x1600@165";
        scale = 1.25;
      }
    ];
    config = {
      general.allow_tearing = true;
      input.sensitivity = 0.1;
    };
    env = {
      _args = [
        "WLR_DRM_NO_ATOMIC"
        "1"
      ]; # because of amd gpu
    };
  };

  # MultiGPU
  #wayland.windowManager.hyprland.settings.env = [ "WLR_DRM_DEVICES,/dev/dri/card1:/dev/dri/card0" ];
}
