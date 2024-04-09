{ lib, ... }: with lib.dafitt; {
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
  ];

  dafitt = {
    battery = enable;
    bootloader.grub = enable;
    desktops.hyprland = enable;
    flatpak = enable;
    networking.connman = enable;
    syncthing.openFirewall = true;
  };
}
