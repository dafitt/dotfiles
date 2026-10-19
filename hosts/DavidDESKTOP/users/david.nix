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
    torrenting
  ];

  programs.umbriel.settings.output."LG Electronics LG ULTRAGEAR+ 412NTAB4B136".min_workspaces = 5;

  programs.umbriel.settings.window_rule = [
    {
      match.app_id = "^sh.ppy.osu$";
      tearing = true;
    }
  ];

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
