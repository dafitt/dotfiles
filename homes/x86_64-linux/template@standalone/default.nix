{ ... }: {

  custom = {
    desktops.gnome.enable = true;
    desktops.hyprland = {
      enable = true;
      monitors = [
        #{
        #  name = "DP-1";
        #  width = 2560;
        #  height = 1440;
        #  refreshRate = 120;
        #  workspace = "1";
        #  primary = true;
        #}
      ];
      hypridle.timeouts = {
        #lock = 0;
        #suspend = 0;
      };
    };

    shells.fish.enable = true;

    development.enableSuite = true;
    editing.enableSuite = true;
    gaming.enableSuite = true;
    music.enableSuite = true;
    office.enableSuite = true;
    social.enableSuite = true;
  };

  home.stateVersion = "23.11";
}
