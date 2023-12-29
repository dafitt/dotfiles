{
  imports = [
    ./home.nix
    ./configurations/Hyprland
    ./modules
    ./programs
    ./services
  ];

  wayland.windowManager.hyprland = {
    monitors = [
      {
        name = "eDP-2";
        width = 1920; # 16:10
        height = 1200;
        refreshRate = 165;
        workspace = "1";
        primary = true;
      }
    ];
  };
}
