{ ... }: {

  custom.desktops.hyprland = {
    monitors = [{
      name = "eDP-2";
      width = 1920; # 16:10
      height = 1200;
      refreshRate = 165;
      workspace = "1";
      primary = true;
    }];
  };

  home.stateVersion = "23.05";
}
