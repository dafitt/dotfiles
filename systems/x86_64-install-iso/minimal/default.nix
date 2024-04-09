#$ nix build .#install-isoConfigurations.minimal

{ lib, ... }: with lib.dafitt; {

  dafitt = {
    bootloader.systemd-boot = enable;
    desktops.hyprland = enable;
    development.enableSuite = true;
    fwupd = enable;
  };

  system.stateVersion = "23.11";
}
