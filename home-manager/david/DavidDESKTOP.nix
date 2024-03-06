{
  imports = [
    ./home.nix
    ./environments/GNOME
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
}
