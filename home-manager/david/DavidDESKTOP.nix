{
  imports = [
    ./home.nix
    ./configurations/Hyprland
    ./modules
    ./programs
    ./services
  ];

  #  ------
  # | DP-1 |
  #  ------
  wayland.windowManager.hyprland.monitors = [
    {
      name = "DP-1";
      width = 2560;
      height = 1440;
      refreshRate = 120;
      workspace = "1";
      primary = true;
    }
  ];

  services.swayidle = {
    timeout.lock = 0;
    timeout.suspend = 0;
  };
}
