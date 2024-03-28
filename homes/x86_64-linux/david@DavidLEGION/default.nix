{ ... }: {

  custom = {
    desktops.hyprland.monitors = [{
      name = "eDP-2";
      width = 1920; # 16:10
      height = 1200;
      refreshRate = 165;
      workspace = "1";
      primary = true;
    }];

    office.enableSuite = true;
    social.enableSuite = true;

    web.librewolf.defaultApplication = true;
  };

  # MultiGPU
  wayland.windowManager.hyprland.settings.env = [ "WLR_DRM_DEVICES,/dev/dri/card1:/dev/dri/card0" ];

  home.stateVersion = "23.05";
}
