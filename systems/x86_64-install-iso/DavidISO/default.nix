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
    enableDefaults = true;

    bootloader.enable = null;
    fwupd.enable = true;
    hyprland.enable = true;
    networking.enable = null;
    suiteDevelopment.enable = true;
    #TODO autologin main user?
  };

  environment.systemPackages = with pkgs; [
  ];

  system.stateVersion = "24.05";
}
