{ lib, ... }: with lib.dafitt; {

  dafitt = {
    desktops.hyprland.monitors = [{
      name = "eDP-2";
      width = 1920; # 16:10
      height = 1200;
      refreshRate = 165;
      workspace = "1";
      primary = true;
    }];

    environment.filemanagers.yazi.enable = true;
    office.enableSuite = true;
    social.enableSuite = true;
  };

  # MultiGPU
  wayland.windowManager.hyprland.settings.env = [ "WLR_DRM_DEVICES,/dev/dri/card1:/dev/dri/card0" ];
}
