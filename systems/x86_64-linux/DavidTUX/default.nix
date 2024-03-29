{ lib, ... }: with lib.custom; {
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
  ];

  custom = {
    battery = enable;
    bootloader.grub = enable;
    desktops.hyprland = enable;
    flatpak = enable;
    networking.connman = enable;
    syncthing.openFirewall = true;
  };
}
