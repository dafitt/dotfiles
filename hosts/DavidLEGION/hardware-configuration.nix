{
  config,
  lib,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "thunderbolt"
    "usbhid"
    "usb_storage"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  # Swap & hibernation
  boot.kernel.sysctl = {
    "vm.swappiness" = 10; # reduce swappiness
  };
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 35 * 1024; # in MiB
    }
  ];
  boot.resumeDevice = "/dev/disk/by-uuid/dbab5f10-713f-4ce3-92bd-6cfdb4bfc0f8";
  #$ sudo filefrag -v /var/lib/swapfile | awk '$1=="0:" {print $4}' | tr -d '.'
  boot.kernelParams = [ "resume_offset=148119552" ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp5s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp4s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
