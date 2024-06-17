# Mainboard: Micro-Star International Co., Ltd. MEG B550 UNIFY-X (MS-7D13)
# CPU: AMD Ryzen 7 5700X (16) @ 3.400GHz
# GPU: AMD ATI Radeon RX 6650 XT
# Memory: 64GB
# Case: Dark Base 900 Orange

#nix-repl> nixosConfigurations.DavidDESKTOP.config

{ options, config, lib, pkgs, inputs, ... }:

with lib;
with lib.dafitt; {
  imports = with inputs; [
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

  environment.systemPackages = with pkgs; [
    lact # Linux AMDGPU Controller
  ];

  # Skip the boot selection menu. [space] to open it.
  boot.loader.timeout = 0;

  fileSystems = {
    "/mnt/games" = {
      label = "GAMES"; # [How to write a label](https://wiki.archlinux.org/title/persistent_block_device_naming#by-label)
      options = [
        # [options](https://man.archlinux.org/man/mount.8#COMMAND-LINE_OPTIONS)
        "defaults"
        #"user"
        #"nofail"
        "x-gvfs-show"
        "X-mount.mkdir" # create directory if not existing
      ];
    };
    "/mnt/file" = {
      label = "FILE";
      options = [
        "defaults"
        "user"
        "nofail"
        "x-gvfs-show"
        "X-mount.mkdir" # create directory if not existing
      ];
    };
  };

  security.sudo.wheelNeedsPassword = false;

  system.stateVersion = "23.11";
}
