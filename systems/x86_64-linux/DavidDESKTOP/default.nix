# Mainboard: Micro-Star International Co., Ltd. MEG B550 UNIFY-X (MS-7D13)
# CPU: AMD Ryzen 7 5700X (16) @ 3.400GHz
# GPU: AMD ATI Radeon RX 6650 XT
# Memory: 64GB
# Case: Dark Base 900 Orange

{ lib, ... }: with lib.custom; {
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
    ./zfs.nix
    ./miniDLNA.nix
  ];

  custom = {
    appimage = enable;
    bootloader.systemd-boot = enable;
    desktops.gnome = enable;
    desktops.hyprland = enable;
    development.enableSuite = true;
    displayManager.greetd = enable;
    flatpak = enable;
    fwupd = enable;
    gaming.enableSuite = true;
    networking.networkmanager = enable;
    syncthing.openFirewall = true;
    virtualization.virt-manager = enable;
  };
}
