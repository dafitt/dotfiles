{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/5b84f8c5-be81-41d3-9b43-00e1a01f119e";
    fsType = "ext4";
  };

  boot.initrd.luks.devices."luks-7eb5c9a8-9721-4eb7-87c4-758ae7b9a58f".device = "/dev/disk/by-uuid/7eb5c9a8-9721-4eb7-87c4-758ae7b9a58f";

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/0045-E1C0";
    fsType = "vfat";
  };

  # swap
  boot.kernel.sysctl = { "vm.swappiness" = 10; }; # reduce swappiness to 10
  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 16 * 1024; # in MiB
  }];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp2s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlo1.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
