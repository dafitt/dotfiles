#nix-repl> install-isoConfigurations.minimal.config
#$ nix build .#install-isoConfigurations.minimal

{ lib, ... }: with lib.dafitt; {

  dafitt = {
    bootloader.systemd-boot.enable = true;
    desktops.hyprland.enable = true;
    development.enableSuite = true;
    fwupd.enable = true;
  };

  system.stateVersion = "23.11";
}
