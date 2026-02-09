{
  #meta.doc = builtins.toFile "doc.md" "Opens the firewall for syncthing.";

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
