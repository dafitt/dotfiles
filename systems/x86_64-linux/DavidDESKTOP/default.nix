# Mainboard: Micro-Star International Co., Ltd. MEG B550 UNIFY-X (MS-7D13)
# CPU: AMD Ryzen 7 5700X (16) @ 3.400GHz
# GPU: AMD ATI Radeon RX 6650 XT
# Memory: 64GB
# Case: Dark Base 900 Orange

#nix-repl> nixosConfigurations.DavidDESKTOP.config

{ lib, inputs, ... }: with lib.dafitt; {
  imports = with inputs; [
    ./configuration.nix
    ./hardware-configuration.nix
    ./zfs.nix
    ./miniDLNA.nix

    # [HARDWARE_MODULES](https://github.com/NixOS/nixos-hardware/blob/master/flake.nix)
    nixos-hardware.nixosModules.common-cpu-amd
    nixos-hardware.nixosModules.common-gpu-amd
    nixos-hardware.nixosModules.common-pc
    nixos-hardware.nixosModules.common-pc-ssd
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
