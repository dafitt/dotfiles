_: {
  #$ nix build .#install-isoConfigurations.minimal

  custom = {
    bootloader.systemd-boot.enable = true;
    desktops = {
      hyprland.enable = true;
    };
    development.enableSuite = true;
    fwupd.enable = true;
  };

  system.stateVersion = "23.11";
}
