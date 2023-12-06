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
  monitors = [
    {
      name = "DP-1";
      width = 2560;
      height = 1440;
      refreshRate = 144;
      workspace = "1";
      primary = true;
    }
  ];
}
