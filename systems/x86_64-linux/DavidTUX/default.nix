{ config, lib, pkgs, inputs, ... }:

with lib;
with lib.dafitt; {
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
    batteryOptimization.enable = true;
    bootloader.enable = "grub";
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
