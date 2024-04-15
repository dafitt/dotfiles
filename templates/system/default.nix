#$ flake build-system [#<host>]
#$ nix build .#nixosConfigurations.<host>.config.system.build.toplevel
#$ nixos-rebuild build --fast --flake .#<host> --show-trace

#$ flake <test|switch|boot> [#<host>]
#$ sudo nixos-rebuild --flake .#<host> <test|switch|boot>

{ lib, ... }: with lib.dafitt; {
  imports = [ ./hardware-configuration.nix ];

  dafitt = {
    appimage.enable = true;
    audio.enable = true;
    battery.enable = true;
    bootloader.grub.enable = true;
    bootloader.systemd-boot.enable = true;
    desktops.gnome.enable = true;
    desktops.hyprland.enable = true;
    development.direnv.enable = true;
    development.enableSuite = true;
    development.sshAgent.enable = true;
    development.wireshark.enable = true;
    displayManager.gdm.enable = true;
    displayManager.greetd.enable = true;
    flatpak.enable = true;
    fonts.enable = true;
    fstrim.enable = true;
    fwupd.enable = true;
    gaming.enableSuite = true;
    gaming.steam.enable = true;
    locale.enable = true;
    networking.connman.enable = true;
    networking.networkmanager.enable = true;
    printing.enable = true;
    security.doas.enable = true;
    shells.fish.enable = true;
    syncthing.enable = true;
    time.enable = true;
    virtualization.virt-manager.enable = true;
  };

  system.stateVersion = "23.11"; # move this line to hardware-configuration.nix
}
