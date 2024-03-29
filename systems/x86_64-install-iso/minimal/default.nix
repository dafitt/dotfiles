#$ nix build .#install-isoConfigurations.minimal

{ lib, ... }: with lib.custom; {

  custom = {
    bootloader.systemd-boot = enable;
    desktops.hyprland = enable;
    development.enableSuite = true;
    fwupd = enable;
  };

  system.stateVersion = "23.11";
}
