#$ flake build-system [#<host>]
#$ nix build .#nixosConfigurations.<host>.config.system.build.toplevel
#$ nixos-rebuild build --fast --flake .#<host> --show-trace

#$ flake <test|switch|boot> [#<host>]
#$ sudo nixos-rebuild --flake .#<host> <test|switch|boot>

{ lib, ... }: with lib.dafitt; {
  imports = [ ./hardware-configuration.nix ];

  dafitt = {
    appimage = enable;
    audio = enable;
    battery = enable;
    bootloader.grub = enable;
    bootloader.systemd-boot = enable;
    desktops.gnome = enable;
    desktops.hyprland = enable;
    development.direnv = enable;
    development.enableSuite = true;
    development.sshAgent = enable;
    development.wireshark = enable;
    displayManager.gdm = enable;
    displayManager.greetd = enable;
    flatpak = enable;
    fonts = enable;
    fstrim = enable;
    fwupd = enable;
    gaming.enableSuite = true;
    gaming.steam = enable;
    locale = enable;
    networking.connman = enable;
    networking.networkmanager = enable;
    printing = enable;
    security.doas = enable;
    shells.fish = enable;
    syncthing = enable;
    time = enable;
    virtualization.virt-manager = enable;
  };

  system.stateVersion = "23.11"; # move this line to hardware-configuration.nix
}
