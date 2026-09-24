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
    };
  };

  wayland.windowManager.hyprland.settings = {
    config.misc.vrr = 3;
    monitor = [
      {
        output = "desc:LG Electronics LG ULTRAGEAR+ 412NTAB4B136";
        mode = "2560x1440@480.17";
        supports_hdr = 1;
        bitdepth = 10;
      }
    ];

    env = {
      _args = [
        "WLR_DRM_NO_ATOMIC"
        "1"
      ]; # because of amd gpu
    };

    config.general.allow_tearing = true;
    window_rule = [
      {
        match.class = "^sh.ppy.osu$";
        immediate = true;
      }
    ];
  };

  programs.niri.settings.outputs."LG Electronics LG ULTRAGEAR+ 412NTAB4B136".mode = {
    width = 2560;
    height = 1440;
    refresh = 480.17;
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
