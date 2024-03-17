{ ... }: {

  custom = {
    desktops.hyprland = {
      #  ------
      # | DP-1 |
      #  ------
      monitors = [{
        name = "DP-1";
        width = 2560;
        height = 1440;
        refreshRate = 120;
        workspace = "1";
        primary = true;
      }];
      swayidle.timeout = {
        lock = 0;
        suspend = 0;
      };
    };

    editing.enableSuite = true;
    music.enableSuite = true;
    office.enableSuite = true;
    social.enableSuite = true;
  };

  home.stateVersion = "23.05";
}