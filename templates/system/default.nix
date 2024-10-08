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

    appimage.enable = false;

    audio.enable = true;

    battery.enable = false;

    bluetooth.enable = false;

    bootloader.enable = "systemd-boot"; # null or one of [ "grub" "systemd-boot" ]

    desktops.gnome.enable = false;
    desktops.hyprland.enable = true;
    desktops.hyprland.hyprlock.allow = hyprlock_enabled;

    Development.enableSuite = false;
    Development.direnv.enable = Development.enableSuite;
    Development.nix-ld.enable = Development.enableSuite;
    Development.sshAgent.enable = Development.enableSuite;
    Development.wireshark.enable = false;

    displayManager.enable = "greetd"; # null or one of [ "gdm" "greetd" ]

    flatpak.enable = false;

    fonts.enable = true;

    fwupd.enable = false;

    Gaming.enableSuite = false;
    Gaming.gamemode = Gaming.enableSuite;
    Gaming.gamescope = Gaming.enableSuite;

    kernel.enable = true;
    kernel.package = pkgs.linuxPackages_zen;

    locale.enable = true;

    networking.enable = "networkmanager"; # null or one of [ "connman" "networkmanager" ]
    networking.firewall.allowLocalsend = false;
    networking.firewall.allowSyncthing = false;

    printing.enable = false;

    security.certificateFiles.enable = false;

    shells.default = "fish"; # null or one of [ "bash" "fish" ]
    shells.fish.enable = shells.default == "fish";

    systemd.enable = true;

    time.enable = true;

    Virtualization.enableSuite = false;
    Virtualization.virt-manager.enable = Virtualization.enableSuite;
  };

  environment.systemPackages = with pkgs; [
  ];

  # add device-specific nixos configuration here #

  system.stateVersion = "24.04";
}
