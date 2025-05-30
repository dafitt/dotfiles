#nix-repl> nixosConfigurations.DavidDESKTOP.config.snowfallorg.users.david.home.config

{ config, lib, pkgs, inputs, ... }:

with lib;
with lib.dafitt; {
  imports = with inputs; [
    ../../user-configurations/david.nix
  ];

  dafitt = {
    filemanagers.yazi.enable = true;
    hyprland.hypridle.sleepTriggersLock = false;
    hyprland.hypridle.timeouts.lock = 0;
    hyprland.hypridle.timeouts.suspend = 0;
    hyprland.monitors = [{ name = "desc:Microstep MSI MAG271CQP 0x3030424C"; primary = true; width = 2560; height = 1440; refreshRate = 144; }];
    hyprland.plugins.hypr-dynamic-cursors.enable = true;
    launchers.rofi.enable = true;
    suiteEditing.enable = true;
    suiteMusic.enable = true;
    suiteOffice.enable = true;
    #suiteRicing.enable = true; # TODO fixme modules/home/desktops/hyprland/ricing/wallpaper/default.nix
    suiteSocial.enable = true;
    suiteWeb.enable = true;
    zed-editor.enable = true;
  };

  # [Hyprland - Tearing](https://wiki.hyprland.org/Configuring/Tearing/)
  wayland.windowManager.hyprland.settings.general.allow_tearing = true;
  wayland.windowManager.hyprland.settings.env = [ "WLR_DRM_NO_ATOMIC,1" ]; # because of amd gpu

  services.flatpak.overrides."com.valvesoftware.Steam".Context.filesystems = [ "/mnt/games" ];
}
