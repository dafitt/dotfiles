{ ... }: {

  # Skip the boot selection menu. [space] to open it.
  boot.loader.timeout = 0;

  networking.firewall = {
    allowedTCPPorts = [
      22000 # Syncthing traffic
    ];
    allowedUDPPorts = [
      22000 # Syncthing traffic
      21027 # Syncthing discovery
    ];
  };
}
