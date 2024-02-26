{ path, ... }: {
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
  ];

  custom = {
    system = {
      battery.enable = true;
      boot.grub.enable = true;
      networking.connman.enable = true;
    };

    features = {
      desktops.gnome.enable = true;
      desktops.hyprland.enable = true;
      displayManager.gdm.enable = true;
      flatpak.enable = true;
      sshAgent.enable = true;
    };
  };

  system.stateVersion = "23.11"; # Do not touch
}
