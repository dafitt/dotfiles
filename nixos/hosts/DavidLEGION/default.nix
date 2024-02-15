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

{ path, ... }: {

  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
    ./power-management.nix
    ./DavidVPN.nix

    "${path.nixosDir}/users/david.nix"
    "${path.nixosDir}/users/guest.nix"

    "${path.nixosDir}/common"
    "${path.nixosDir}/common/connman.nix"
    "${path.nixosDir}/common/displayManager.nix"
    "${path.nixosDir}/common/flatpak.nix"
    "${path.nixosDir}/common/gamemode.nix"
    "${path.nixosDir}/common/GNOME.nix"
    "${path.nixosDir}/common/Hyprland.nix"
    "${path.nixosDir}/common/nix.nix"
    "${path.nixosDir}/common/ssh.nix"
    "${path.nixosDir}/common/virtualisation.nix"
  ];
}
