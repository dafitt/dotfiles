{ inputs, ... }:

#
# Case:
# Mainboard:
# CPU:
# Memory:
# Disks:
#   -
# Power Supply:
# GPU:
# Display:
# Keyboard:
# Mouse:
# Camera:
# Battery:
# WIFI:
# Bluetooth:
# Color:
{
  nixpkgs.hostPlatform = "x86_64-linux";
  system.stateVersion = "25.11";

  imports =
    with inputs;
    with inputs.self.nixosModules;
    [
      ./hardware-configuration.nix

      disko.nixosModules.disko
      impermanence.nixosModules.impermanence
      ./disk-configuration.nix

      appimage
      audio
      certificates
      coreutils
      desktopEnvironment-hyprland
      documentation
      flatpak
      fonts
      home-manager
      hostName
      kernel
      locale
      localsend
      locate
      nix
      shell-fish
      shell-fish
      stylix
      sudo
      syncthing
      systemd
      tailscale
      time
      user-david
      user-guest
      user-root
    ];
}
