# a minimal host configuration

{ config, lib, pkgs, ... }: {

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;

    # Skip the boot selection menu. [space] to open it.
    timeout = 0;
  };

  boot.kernel.sysctl = { "vm.swappiness" = 10; }; # reduce swappiness


  console.keyMap = "de-latin1-nodeadkeys";


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


  services.fstrim.enable = true; # SSD

  services.blueman.enable = true;


  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  hardware.opengl.enable = true;

  # Discrete Graphics
  #$$ env DRI_PRIME=1 [command] {args}


  system.stateVersion = "23.05"; # Do not touch
}
