# Check:
#$ nix flake check
#$ nix repl
#nix-repl> :lf .
#nix-repl> nixosConfigurations.<host>.config

# Build:
#$ flake build-system [#<host>]
#$ nixos-rebuild build --fast --flake .#<host> --show-trace
#$ nix build .#nixosConfigurations.<host>.config.system.build.toplevel

# Activate:
#$ flake <test|switch|boot> [#<host>]
#$ nixos-rebuild --flake .#<host> <test|switch|boot>
#$ nix run .#nixosConfigurations.<host>.config.system.build.toplevel

{ lib, pkgs, inputs, ... }: with lib.dafitt; {
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

    security.doas.enable = false;

    shells.fish.enable = true;

    time.enable = true;

    Virtualization.enableSuite = false;
    Virtualization.virt-manager.enable = Virtualization.enableSuite;
  };

  environment.systemPackages = with pkgs; [
  ];

  # add device-specific nixos configuration here #

  system.stateVersion = "24.04";
}
