{
  lib,
  pkgs,
  inputs,
  ...
}:

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
with lib;
{
  nixpkgs.hostPlatform = "x86_64-linux";
  system.stateVersion = "23.05";

  imports =
    with inputs;
    with inputs.self.nixosModules;
    [
      ./hardware-configuration.nix

      disko.nixosModules.disko
      ./disk-configuration.nix
      impermanance

      # [HARDWARE_MODULES](https://github.com/NixOS/nixos-hardware/blob/master/flake.nix)
      nixos-hardware.nixosModules.lenovo-legion-16arha7

      ./powerManagement.nix

      SHARED
      batteryOptimization
      bluetooth
      bootloader-limine
      desktopEnvironment-gnome
      development
      gaming
      loginManager-gdm
      networking-networkmanager
      printing
      virtualization
    ];

  services.logind.settings.Login = {
    # logind.conf(5)
    HandlePowerKey = "sleep";
    HandlePowerKeyLongPress = "poweroff";
  };

  services.fprintd.enable = mkForce false; # No fingerprint reader

  environment.systemPackages = with pkgs; [
    lact # Linux AMDGPU Controller
  ];

  boot.loader = {
    efi.canTouchEfiVariables = true;
    timeout = 1;
    systemd-boot.configurationLimit = 5;
  };

  boot.kernel.sysctl."vm.swappiness" = 10; # reduce swappiness
}
