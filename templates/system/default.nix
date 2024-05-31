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

{ lib, ... }: with lib.dafitt; {
  imports = [ ./hardware-configuration.nix ];

  dafitt = rec {
    #NOTE These values are the defaults

    appimage.enable = false;

    audio.enable = true;

    battery.enable = false;

    bootloader.enable = "systemd-boot"; # null or one of [ "grub" "systemd-boot" ]

    desktops.gnome.enable = false;
    desktops.hyprland.enable = true;

    development.direnv.enable = false;
    development.enableSuite = false;
    development.sshAgent.enable = false;
    development.wireshark.enable = false;

    displayManager.enable = "greetd"; # null or one of [ "gdm" "greetd" ]

    flatpak.enable = false;

    fonts.enable = true;

    fstrim.enable = true;

    fwupd.enable = false;

    gaming.enableSuite = false;
    gaming.gamemode = gaming.enableSuite;
    gaming.gamescope = gaming.enableSuite;

    locale.enable = true;

    networking.enable = "networkmanager"; # null or one of [ "connman" "networkmanager" ]
    networking.firewall.allowLocalsend = false;
    networking.firewall.allowSyncthing = false;

    printing.enable = false;

    security.doas.enable = false;

    shells.fish.enable = true;

    time.enable = true;

    virtualization.virt-manager.enable = false;
  };

  system.stateVersion = "23.11"; # move this line to hardware-configuration.nix
}
