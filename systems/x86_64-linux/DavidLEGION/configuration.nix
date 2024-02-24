{ config, lib, pkgs, ... }: {

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;

    # Skip the boot selection menu. [space] to open it.
    timeout = 0;
  };

  boot.kernel.sysctl = { "vm.swappiness" = 10; }; # reduce swappiness


  console.keyMap = "de-latin1-nodeadkeys";


  networking.hostName = "DavidLEGION";
  networking.firewall = {
    allowedTCPPorts = [
      22000 # Syncthing traffic
    ];
    allowedUDPPorts = [
      22000 # Syncthing traffic
      21027 # Syncthing discovery
    ];
  };


  services.fstrim.enable = true; # SSD


  hardware.opengl.enable = true;

  # Discrete Graphics
  #$ env DRI_PRIME=1 [command] {args}

}
