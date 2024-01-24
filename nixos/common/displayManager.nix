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

  programs.dconf.profiles.gdm.databases = [{
    settings = {
      "org/gnome/desktop/peripherals/touchpad".tap-to-click = true;
    };
  }];
}
