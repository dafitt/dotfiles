# Lenovo Legion7 16 ARHA7 Laptop
# - AMD Ryzen 7 6800 H with Radeon Graphics (3,20GHz - 4,70GHz)
# - 32GB (2x16GB) SO-DIMM DDR5 4800MHz
# - AMD Radeon RX 6850M 10GB GDDR6
# - 16" WQXGA (2560x1600px), IPS, Blendschutz, Dolby Vision, Free-Sync, HDR 400, 500 Nits, 165Hz
# - 1080p-FHD Frontcamera
# - 4 cell 99.9Wh
# - WIFI 6E 11AX (2x2)
# - Bluetooth 5.1
# - Storm Grey

{
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
    ./power-management.nix
    ./DavidVPN.nix

    ../../users/david.nix
    ../../users/guest.nix

    ../../common
    ../../common/connman.nix
    ../../common/displayManager.nix
    ../../common/flatpak.nix
    ../../common/gamemode.nix
    ../../common/GNOME.nix
    ../../common/Hyprland.nix
    ../../common/nix.nix
    ../../common/ssh.nix
    ../../common/virtualisation.nix
  ];
}
