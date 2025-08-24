{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

with lib;
with lib.dafitt;
{
  imports = with inputs; [
    ./hardware-configuration.nix

    # [HARDWARE_MODULES](https://github.com/NixOS/nixos-hardware/blob/master/flake.nix)
    nixos-hardware.nixosModules.common-cpu-amd
    nixos-hardware.nixosModules.common-cpu-amd-pstate
    nixos-hardware.nixosModules.common-gpu-amd
    nixos-hardware.nixosModules.common-pc
    nixos-hardware.nixosModules.common-pc-ssd
  ];

  dafitt = {
    enableDefaults = true;

    batteryOptimization.enable = true;
    bootloader.grub.enable = true;
    bootloader.systemd-boot.enable = false;
    displayManager.gdm.enable = true;
    flatpak.enable = true;
    hyprland.enable = true;
    networking.firewall.allowLocalsend = true;
    networking.firewall.allowSyncthing = true;
  };

  environment.systemPackages = with pkgs; [
  ];

  boot.loader.timeout = 10;

  hardware.tuxedo-rs = {
    enable = true;
    tailor-gui.enable = true;
  };

  system.stateVersion = "23.05";
}
