#nix-repl> install-isoConfigurations.DavidISO.config

#$ nix build .#install-isoConfigurations.DavidISO

{ config, lib, pkgs, inputs, ... }:

with lib;
with lib.dafitt; {
  imports = with inputs; [
    # automatically applied by inputs.nixos-generators:
    # https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix
    # https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/installer/cd-dvd/installation-cd-base.nix
    # https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/profiles/installation-device.nix
  ];

  isoImage.squashfsCompression = "zstd -3";

  dafitt = {
    bootloader.enable = null;
    desktops.hyprland.enable = true;
    suiteDevelopment.enable = true;
    displayManager.enable = null;
    fwupd.enable = true;
    kernel.package = config.boot.zfs.package.latestCompatibleLinuxPackages;
    networking.enable = null;
    #TODO autologin main user?
  };

  environment.systemPackages = with pkgs; [
  ];

  system.stateVersion = "24.05";
}
