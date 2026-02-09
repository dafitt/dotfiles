{
  meta.doc = "Opens the firewall for syncthing.";

  networking.firewall = {
    allowedTCPPorts = [
      22000
    ];
    allowedUDPPorts = [
      22000
      21027
    ];
  };
}
