{ config, inputs, ... }:

#> perSystem.self.homeConfigurations."david@DavidDESKTOP"
{
  home.stateVersion = "23.11";
  # default behavior changes
  programs.firefox.configPath = "${config.xdg.configHome}/mozilla/firefox";

  imports = with inputs.self.homeModules; [
    imports
    user-david

    comics
    development
    editing
    fileManager-thunar
    fileManager-yazi
    gaming
    music
    networking-networkmanager
    office
    ricing
    social
    web
  ];

  dafitt = {
    desktopEnvironment-hyprland = {
      hypridle.sleepTriggersLock = false;
      hypridle.timeouts.lock = 0;
      hypridle.timeouts.suspend = 0;
      plugins.hypr-dynamic-cursors.enable = true;
    };
  };

  wayland.windowManager.hyprland.settings.monitor = [
    {
      output = "desc:Microstep MSI MAG271CQP 0x3030424C";
      mode = "2560x1440@144";
    }
  ];

  # [Hyprland - Tearing](https://wiki.hypr.land/Configuring/Tearing/)
  wayland.windowManager.hyprland.settings.config.general.allow_tearing = true;
  wayland.windowManager.hyprland.settings.env = {
    _args = [
      "WLR_DRM_NO_ATOMIC"
      "1"
    ]; # because of amd gpu
  };

  programs.niri.settings.outputs."Microstep MSI MAG271CQP 0x3030424C".mode = {
    width = 2560;
    height = 1440;
    refresh = 143.999;
  };

  services.flatpak.overrides."com.valvesoftware.Steam" = {
    Context.filesystems = [
      "/DavidGAMES"
      "/home/david/.config/MangoHud/config:ro"
    ];
    Environment = {
      # https://github.com/flightlessmango/MangoHud?tab=readme-ov-file#environment-variables
      MANGOHUD = "1";
      MANGOHUD_CONFIGFILE = "/home/david/.config/MangoHud/config";
      # MANGOHUD_CONFIG = "full,no_display,fps_limit=144";
    };
  };

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
