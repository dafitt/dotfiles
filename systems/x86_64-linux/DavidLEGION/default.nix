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

{ config, lib, pkgs, inputs, ... }:

with lib;
with lib.dafitt; {
  imports = with inputs; [
    ./hardware-configuration.nix
    ./power-management.nix
    ./DavidVPN.nix

    # [HARDWARE_MODULES](https://github.com/NixOS/nixos-hardware/blob/master/flake.nix)
    nixos-hardware.nixosModules.common-cpu-amd
    nixos-hardware.nixosModules.common-cpu-amd-pstate
    nixos-hardware.nixosModules.common-gpu-amd
    nixos-hardware.nixosModules.common-pc
    nixos-hardware.nixosModules.common-pc-ssd
  ];

  dafitt = {
    enable = true;

    bluetooth.enable = true;
    displayManager.gdm.enable = true;
    displayManager.greetd.enable = false;
    flatpak.enable = true;
    gnome.enable = true;
    networking.firewall.allowLocalsend = true;
    networking.firewall.allowSyncthing = true;
    suiteDevelopment.enable = true;
    suiteVirtualization.enable = true;
  };

  environment.systemPackages = with pkgs; [
    lact # Linux AMDGPU Controller
  ];

  # Skip the boot selection menu. [space] to open it.
  boot.loader.timeout = 0;

  #$ ssh-keyscan
  programs.ssh.knownHosts."minisforumhm80.schallernetz.lan".publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ8HMHua73rLpiJOQRjVbfMhzWMFi9F9a1xpqUt4nLhD";

  system.stateVersion = "23.05";
}
