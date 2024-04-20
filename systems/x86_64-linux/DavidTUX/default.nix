{ lib, ... }: with lib.dafitt; {
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
  ];

  dafitt = {
    battery.enable = true;
    bootloader.enable = "grub";
    flatpak.enable = true;
    networking.enable = "connman";
    syncthing.openFirewall = true;
  };
}
