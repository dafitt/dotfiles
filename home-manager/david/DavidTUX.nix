{
  imports = [
    ./home.nix
  ];

  wayland.windowManager.hyprland.monitors = [
    {
      name = "eDP-1";
      width = 1920;
      height = 1080;
      refreshRate = 60;
      workspace = "1";
      primary = true;
    }
  ];
}
