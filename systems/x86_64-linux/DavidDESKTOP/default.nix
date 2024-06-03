# Mainboard: Micro-Star International Co., Ltd. MEG B550 UNIFY-X (MS-7D13)
# CPU: AMD Ryzen 7 5700X (16) @ 3.400GHz
# GPU: AMD ATI Radeon RX 6650 XT
# Memory: 64GB
# Case: Dark Base 900 Orange

#nix-repl> nixosConfigurations.DavidDESKTOP.config

{ lib, ... }: with lib.dafitt; {
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
    ./zfs.nix
    ./miniDLNA.nix
  ];

  dafitt = {
    appimage.enable = true;
    desktops.gnome.enable = true;
    Development.enableSuite = true;
    flatpak.enable = true;
    fwupd.enable = true;
    Gaming.enableSuite = true;
    networking.firewall.allowLocalsend = true;
    networking.firewall.allowSyncthing = true;
    printing.enable = true;
    Virtualization.virt-manager.enable = true;
  };
}
