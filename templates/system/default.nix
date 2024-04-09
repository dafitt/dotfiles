#$ flake build-system [#<name>]
#$ nix build .#nixosConfigurations.<name>.config.system.build.toplevel
#$ nixos-rebuild build --flake .[#<name>] --show-trace
#$ nixos-rebuild build-vm --flake .[#<name>]

#$ flake test [#<name>]
#$ flake switch [#<name>]
#$ flake boot [#<name>]
#$ sudo nixos-rebuild test --flake .[#<name>]
#$ sudo nixos-rebuild switch --flake .[#<name>]
#$ sudo nixos-rebuild boot --flake .[#<name>]

{ lib, ... }: with lib.custom; {
  imports = [ ./hardware-configuration.nix ];

  custom = {
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
