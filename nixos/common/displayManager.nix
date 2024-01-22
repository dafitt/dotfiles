{
  # Login/Display Manager
  services.xserver.enable = true;
  services.xserver.displayManager = {
    gdm = {
      enable = true;
      wayland = true;
    };
    defaultSession = "hyprland";
  };
}
