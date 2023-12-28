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
  connman = {
    enable = true;
    wifi.backend = "iwd";
  };


  services.fstrim.enable = true; # SSD


  hardware.opengl.enable = true;

  # Discrete Graphics
  #$ env DRI_PRIME=1 [command] {args}


  system.stateVersion = "23.05"; # Do not touch
}
