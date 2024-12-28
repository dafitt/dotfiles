# Check:
#$ nix flake check
#$ nixos-rebuild repl --fast --flake .#<host>
#nix-repl> nixosConfigurations.<host>.config

# Build:
#$ nixos-rebuild build --fast --flake .#<host>
#$ nix build .#nixosConfigurations.<host>.config.system.build.toplevel

# Activate:
#$ nixos-rebuild --flake .#<host> <test|switch|boot>
#$ nix run .#nixosConfigurations.<host>.config.system.build.toplevel

{ config, lib, pkgs, inputs, ... }:

with lib;
with lib.dafitt; {
  imports = with inputs; [
    ./hardware-configuration.nix

    # [HARDWARE_MODULES](https://github.com/NixOS/nixos-hardware/blob/master/flake.nix)
    #nixos-hardware.nixosModules.<HARDWARE_MODULE>
  ];

  dafitt = rec {
    #NOTE These are the defaults that were taken from
    #$ nixos-rebuild --flake .#defaults repl
    #> :p config.dafitt

    appimage = { enable = true; };
    audio = { enable = true; };
    batteryOptimization = { enable = false; };
    bluetooth = { enable = false; };
    bootloader = {
      enable = "systemd-boot";
      grub = { enable = false; };
      systemd-boot = { enable = true; };
    };
    displayManager = {
      enable = "greetd";
      gdm = { enable = false; };
      greetd = { enable = true; };
      sessionPaths = [
        "/nix/store/9pgg2wwp4g90z0jsq7y09rpmiyrvr00x-bash-session.desktop/share/applications"
        "/nix/store/35rd09ksrlb37pyyv23g76kwybqil9nf-desktops/share/xsessions"
        "/nix/store/35rd09ksrlb37pyyv23g76kwybqil9nf-desktops/share/wayland-sessions"
      ];
    };
    flatpak = { enable = false; };
    fonts = {
      enable = true;
      fonts = [ ];
    };
    fwupd = { enable = false; };
    gnome = { enable = false; };
    hyprland = {
      enable = false;
      hyprlock = { allow = false; };
    };
    kernel = {
      enable = true;
      package = pkgs.linuxPackages_latest;
    };
    locale = { enable = true; };
    locate = { enable = true; };
    networking = {
      connman = { enable = false; };
      enable = "networkmanager";
      firewall = {
        allowLocalsend = false;
        allowSyncthing = false;
      };
      networkmanager = { enable = true; };
    };
    printing = { enable = false; };
    shells = {
      default = "fish";
      fish = { enable = true; };
    };
    suiteDevelopment = { enable = false; };
    suiteGaming = { enable = false; };
    suiteVirtualization = { enable = false; };
    systemd = { enable = true; };
    time = { enable = true; };
    users = {
      guest = { enable = true; };
    };
  };

  environment.systemPackages = with pkgs; [
  ];

  # add device-specific nixos configuration here #

  system.stateVersion = "24.04";
}
