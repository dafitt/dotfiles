{ ... }: {

  custom = {
    desktops.common.bedtime.enable = true;
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
      hypridle.timeouts = {
        lock = 0;
        suspend = 0;
      };
    };

    editing.enableSuite = true;
    music.enableSuite = true;
    office.enableSuite = true;
    social.enableSuite = true;

    web.librewolf.defaultApplication = true;
  };

  services.flatpak.overrides."com.valvesoftware.Steam".Context.filesystems = [ "/mnt/games" ];

  home.stateVersion = "23.11";
}
