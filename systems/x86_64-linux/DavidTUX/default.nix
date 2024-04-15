{ lib, ... }: with lib.dafitt; {
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
  ];

  dafitt = {
    battery.enable = true;
    bootloader.enable = "grub";
    desktops.hyprland.enable = true;
    flatpak.enable = true;
    networking.connman.enable = true;
    syncthing.openFirewall = true;
  };
}
