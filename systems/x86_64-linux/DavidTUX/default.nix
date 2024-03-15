{ ... }: {
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
  ];

  custom = {
    battery.enable = true;
    bootloader.grub.enable = true;
    desktops.hyprland.enable = true;
    flatpak.enable = true;
    networking.connman.enable = true;
  };
}
