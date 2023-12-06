# a minimal host configuration

{ config, pkgs, ... }: {


  imports = [
    ./hardware-configuration.nix
    ../common-desktop.nix
  ];


  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };


  console.keyMap = "de";


  networking = {
    hostName = "nixos"; # Define your hostname.

    networkmanager.enable = true;
  };


  system.stateVersion = "23.05"; # Do not touch
}
