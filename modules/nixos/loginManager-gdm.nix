{
  #meta.doc = builtins.toFile "doc.md" "Enables and configures the login manager GDM.";

  services.displayManager.gdm = {
    enable = true;
    wayland = true;
  };

  programs.dconf.profiles.gdm.databases = [
    {
      settings = {
        "org/gnome/desktop/peripherals/touchpad".tap-to-click = true;
      };
    }
  ];
}
