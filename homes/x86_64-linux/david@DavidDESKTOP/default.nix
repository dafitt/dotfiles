#nix-repl> nixosConfigurations.DavidDESKTOP.config.snowfallorg.users.david.home.config

{ config, lib, pkgs, inputs, ... }:

with lib;
with lib.dafitt; {
  imports = with inputs; [ ];

  dafitt = {
    desktops.hyprland.hypridle.sleepTriggersLock = false;
    desktops.hyprland.hypridle.timeouts.lock = 0;
    desktops.hyprland.hypridle.timeouts.suspend = 0;
    Editing.enableSuite = true;
    environment.bedtime.enable = true;
    environment.filemanagers.yazi.enable = true;
    environment.launchers.rofi.enable = true;
    Music.enableSuite = true;
    Office.enableSuite = true;
    #Ricing.enableSuite = true; # TODO fixme modules/home/desktops/hyprland/ricing/wallpaper/default.nix
    Social.enableSuite = true;
    Web.enableSuite = true;
  };

  # [Hyprland - Tearing](https://wiki.hyprland.org/Configuring/Tearing/)
  wayland.windowManager.hyprland.settings.general.allow_tearing = true;
  wayland.windowManager.hyprland.settings.env = [ "WLR_DRM_NO_ATOMIC,1" ]; # because of amd gpu

  services.flatpak.overrides."com.valvesoftware.Steam".Context.filesystems = [ "/mnt/games" ];
}
