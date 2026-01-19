{ inputs, ... }:

#> perSystem.self.homeConfigurations."david@DavidDESKTOP"
{
  home.stateVersion = "23.11";

  imports =
    with inputs;
    with inputs.self.homeModules;
    [
      SHARED
      bluetooth
      development
      editing
      fileManager-thunar
      fileManager-yazi
      gaming
      office
      ricing
      social
      user-david
      web
    ];

  dafitt = {
    desktopEnvironment-hyprland = {
      monitors = [
        {
          name = "desc:Microstep MSI MAG271CQP 0x3030424C";
          primary = true;
          width = 2560;
          height = 1440;
          refreshRate = 144;
        }
      ];
      hypridle.sleepTriggersLock = false;
      hypridle.timeouts.lock = 0;
      hypridle.timeouts.suspend = 0;
      plugins.hypr-dynamic-cursors.enable = true;
    };
  };

  # [Hyprland - Tearing](https://wiki.hypr.land/Configuring/Tearing/)
  wayland.windowManager.hyprland.settings.general.allow_tearing = true;
  wayland.windowManager.hyprland.settings.env = [ "WLR_DRM_NO_ATOMIC,1" ]; # because of amd gpu

  programs.niri.settings.outputs."Microstep MSI MAG271CQP 0x3030424C".mode = {
    width = 2560;
    height = 1440;
    refresh = 143.999;
  };

  services.flatpak.overrides."com.valvesoftware.Steam".Context.filesystems = [ "/DavidGAMES" ];

  # Bookmarks #
  gtk.gtk3.bookmarks = [
    "file:///DavidGAMES"
  ];
  programs.yazi.keymap.mgr.append_keymap = [
    {
      on = [
        "g"
        "G"
      ];
      run = "cd /DavidGAMES";
      desc = "Go to /DavidGAMES";
    }
  ];
}
