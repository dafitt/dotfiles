{
  imports = [
    ./home.nix
    ./configurations/Hyprland
    ./modules
    ./programs
    ./services
  ];

  monitors = [
    {
      name = "eDP-1";
      width = 2560;
      height = 1440;
      refreshRate = 90;
      workspace = "1";
      primary = true;
    }
  ];

  wayland.windowManager.hyprland.extraConfig = ''
    misc:disable_autoreload = true
  '';
}
