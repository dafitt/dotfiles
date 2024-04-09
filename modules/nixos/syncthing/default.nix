{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.syncthing;
in
{
  options.dafitt.syncthing = with types; {
    openFirewall = mkBoolOpt false "Whether or not open syncthing discovery ports";
  };

  config = mkIf cfg.openFirewall {
    networking.firewall = {
      allowedTCPPorts = [
        22000 # Syncthing traffic
      ];
      allowedUDPPorts = [
        22000 # Syncthing traffic
        21027 # Syncthing discovery
      ];
    };
  };
}
