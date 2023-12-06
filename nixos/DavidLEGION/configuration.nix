# a minimal host configuration

{ config, lib, pkgs, ... }: {


  imports = [
    # FIXME import nixos-hardware
    #<nixos-hardware/common/cpu/amd>
    #<nixos-hardware/common/gpu/amd>
    ../common-desktop.nix
  ];


  boot.loader = {
    systemd-boot.enable = true;
    grub = {
      enable = false;
      device = "nodev";
      efiSupport = true;
    };
    efi.canTouchEfiVariables = true;

    # Skip the boot selection menu. [space] to open it.
    timeout = 0;
  };


  console.keyMap = "de-latin1-nodeadkeys";


  boot.kernel.sysctl = { "vm.swappiness" = 10; }; # reduce swappiness

  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 35 * 1024; # in MiB
  }];


  networking = {
    hostName = "DavidLEGION"; # Define your hostname.

    firewall = {
      allowedTCPPorts = [
        #25 465 587 # SMTP
        #143 993 # IMAP
        22000 # syncthing
      ];
      allowedUDPPorts = [
        21027 # syncthing broadcast
        22000 # syncthing
      ];
      allowedTCPPortRanges = [
        #{ from = 27015; to = 27050; } # Steam
      ];
      allowedUDPPortRanges = [
        #{ from = 27015; to = 27050; } # Steam
      ];
    };
  };


  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };


  services = {

    fstrim.enable = true; # SSD

    blueman.enable = true;

  };


  # Discrete Graphics
  #$$ env DRI_PRIME=1 [command] {args}


  system.stateVersion = "23.05"; # Do not touch
}
