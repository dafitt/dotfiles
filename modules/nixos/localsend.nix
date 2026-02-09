{
  #meta.doc = builtins.toFile "doc.md" "Opens the firewall for localsend.";

  networking.firewall = {
    allowedTCPPorts = [ 53317 ];
    allowedUDPPorts = [ 53317 ];
  };
}
