{ ... }: {
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
  ];

  custom = {
    system = {
      battery.enable = true;
      bootloader.grub.enable = true;
      networking.connman.enable = true;
    };

    desktops.gnome.enable = true;
    desktops.hyprland.enable = true;
    displayManager.gdm.enable = true;
    development.sshAgent.enable = true;
    flatpak.enable = true;
  };

  system.stateVersion = "23.11"; # Do not touch
}
