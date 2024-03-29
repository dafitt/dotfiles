{ lib, ... }: with lib.custom; {

  custom = {
    desktops.hyprland.monitors = [{
      name = "eDP-1";
      width = 1920;
      height = 1080;
      refreshRate = 60;
      workspace = "1";
      primary = true;
    }];

    development.enableSuite = true;
    social.enableSuite = true;
  };

  home.stateVersion = "23.05";
}
