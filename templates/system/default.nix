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
    #NOTE These values are the defaults
    appimage.enable = true;
    audio.enable = true;
    batteryOptimization.enable = false;
    bluetooth.enable = false;
    bootloader.enable = "systemd-boot"; # null or one of [ "grub" "systemd-boot" ]
    displayManager.enable = "greetd"; # null or one of [ "gdm" "greetd" ]
    flatpak.enable = false;
    fonts.enable = true;
    fwupd.enable = false;
    gnome.enable = false;
    hyprland.enable = true;
    hyprland.hyprlock.allow = hyprlock_enabled;
    kernel.enable = true;
    kernel.package = if zfs then pkgs.linuxPackages else pkgs.linuxPackages_latest;
    locale.enable = true;
    networking.enable = "networkmanager"; # null or one of [ "connman" "networkmanager" ]
    networking.firewall.allowLocalsend = false;
    networking.firewall.allowSyncthing = false;
    printing.enable = false;
    shells.default = "fish"; # null or one of [ "bash" "fish" ]
    shells.fish.enable = shells.default == "fish";
    suiteDevelopment.enable = false;
    suiteGaming.enable = false;
    suiteVirtualization.enable = false;
    systemd.enable = true;
    time.enable = true;
    users.guest.enable = true;
  };

  environment.systemPackages = with pkgs; [
  ];

  # add device-specific nixos configuration here #

  system.stateVersion = "24.04";
}
