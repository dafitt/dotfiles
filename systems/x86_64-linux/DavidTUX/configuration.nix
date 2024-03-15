{ ... }: {

  boot.loader.timeout = 5;

  hardware.tuxedo-rs = {
    enable = true;
    tailor-gui.enable = true;
  };

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
