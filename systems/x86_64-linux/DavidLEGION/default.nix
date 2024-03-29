# Lenovo Legion7 16 ARHA7 Laptop
# CPU: AMD Ryzen 7 6800 H with Radeon Graphics (3,20GHz - 4,70GHz)
# RAM: 32GB (2x16GB) SO-DIMM DDR5 4800MHz
# GPU: AMD Radeon RX 6850M 10GB GDDR6
# Display: 16" WQXGA (2560x1600px), IPS, Blendschutz, Dolby Vision, Free-Sync, HDR 400, 500 Nits, 165Hz
# Camera: 1080p-FHD Frontcamera
# Battery: 4 cell 99.9Wh
# WIFI: 6E 11AX (2x2)
# Bluetooth: 5.1
# Color: Storm Grey

{ lib, ... }: with lib.custom; {
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
    ./power-management.nix
    ./DavidVPN.nix
  ];

  custom = {
    bootloader.systemd-boot = enable;
    desktops.gnome = enable;
    desktops.hyprland = enable;
    development.enableSuite = true;
    displayManager.greetd = enable;
    flatpak = enable;
    fwupd = enable;
    networking.connman = enable;
    syncthing.openFirewall = true;
    virtualization.virt-manager = enable;
  };
}
