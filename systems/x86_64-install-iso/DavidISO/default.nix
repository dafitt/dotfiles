#nix-repl> install-isoConfigurations.minimal.config
#$ nix build .#install-isoConfigurations.minimal

{ lib, pkgs, inputs, ... }: with lib.dafitt; {
  imports = with inputs; [ ];

  dafitt = {
    bootloader.systemd-boot.enable = true;
    desktops.hyprland.enable = true;
    Development.enableSuite = true;
    fwupd.enable = true;
  };

  system.stateVersion = "24.05";
}
