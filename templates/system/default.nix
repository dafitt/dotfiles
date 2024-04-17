# Check:
#$ nix flake check
#$ nix repl .#nixosConfigurations.<host>

# Build:
#$ flake build-system [#<host>]
#$ nixos-rebuild build --fast --flake .#<host> --show-trace
#$ nix build .#nixosConfigurations.<host>.config.system.build.toplevel

# Activate:
#$ flake <test|switch|boot> [#<host>]
#$ nixos-rebuild --flake .#<host> <test|switch|boot>
#$ nix run .#nixosConfigurations.<host>.config.system.build.toplevel

{ lib, ... }: with lib.dafitt; {
  imports = [ ./hardware-configuration.nix ];

  dafitt = rec {
    #NOTE These are the defaults

    appimage.enable = false;

    audio.enable = true;

    battery.enable = false;

    bootloader.enable = "systemd-boot"; # nullOr (enum [ "grub" "systemd-boot" ])

    desktops.gnome.enable = false;
    desktops.hyprland.enable = false;

    development.direnv.enable = false;
    development.enableSuite = false;
    development.sshAgent.enable = false;
    development.wireshark.enable = false;

    displayManager.enable = "greetd"; # nullOr (enum [ "gdm" "greetd" ])

    flatpak.enable = false;

    fonts.enable = true;

    fstrim.enable = true;

    fwupd.enable = false;

    gaming.enableSuite = false;
    gaming.steam.enable = false;

    locale.enable = true;

    networking.enable = "networkmanager"; # nullOr (enum [ "connman" "networkmanager" ])

    printing.enable = false;

    security.doas.enable = false;

    shells.fish.enable = true;

    syncthing.openFirewall = false;

    time.enable = true;

    virtualization.virt-manager.enable = false;
  };

  system.stateVersion = "23.11"; # move this line to hardware-configuration.nix
}
