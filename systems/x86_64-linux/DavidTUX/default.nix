{ ... }: {
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
  ];

  custom = {
    battery.enable = true;
    bootloader.grub.enable = true;
    desktops.gnome.enable = true;
    desktops.hyprland.enable = true;
    development.sshAgent.enable = true;
    displayManager.gdm.enable = true;
    flatpak.enable = true;
    networking.connman.enable = true;
  };
}
