{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.networking.firewall;
in
{
  options.dafitt.networking.firewall = with types; {
    allowLocalsend = mkEnableOption "localsend protocol ports";
    allowSyncthing = mkEnableOption "syncthing protocol ports";
  };

  config = {
    networking.firewall =
      { }
      // optionalAttrs cfg.allowLocalsend {
        allowedTCPPorts = [ 53317 ];
        allowedUDPPorts = [ 53317 ];
      }
      // optionalAttrs cfg.allowSyncthing {
        allowedTCPPorts = [ 22000 ];
        allowedUDPPorts = [
          22000
          21027
        ];
      };
  };
}
