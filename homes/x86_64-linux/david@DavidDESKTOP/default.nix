#nix-repl> nixosConfigurations.DavidDESKTOP.config.snowfallorg.users.david.home.config

{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

with lib;
with lib.dafitt;
{
  imports = with inputs; [
    ../../user-configurations/david.nix
  ];

  dafitt = {
    hyprland = {
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
    #suiteRicing.enable = true; # TODO fixme modules/home/desktops/hyprland/ricing/wallpaper/default.nix
    nautilus.setAsDefaultFileManager = false;
    rofi.enable = true;
    suiteEditing.enable = true;
    suiteMusic.enable = true;
    suiteOffice.enable = true;
    suiteSocial.enable = true;
    suiteWeb.enable = true;
    yazi.enable = true;
    yazi.setAsDefaultFileManager = true;
  };

  # [Hyprland - Tearing](https://wiki.hyprland.org/Configuring/Tearing/)
  wayland.windowManager.hyprland.settings.general.allow_tearing = true;
  wayland.windowManager.hyprland.settings.env = [ "WLR_DRM_NO_ATOMIC,1" ]; # because of amd gpu

  services.flatpak.overrides."com.valvesoftware.Steam".Context.filesystems = [ "/DavidGAMES" ];

  # Bookmarks #
  gtk.gtk3.bookmarks = [
    "file:///DavidARCHIVE"
    "file:///DavidGAMES"
  ];
  programs.yazi.keymap.mgr.append_keymap = [
    {
      on = [
        "g"
        "A"
      ];
      run = "cd /DavidARCHIVE";
      desc = "Go to /DavidARCHIVE";
    }
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
