{ options, config, lib, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.networking.connman;
in
{
  options.custom.networking.connman = with types; {
    enable = mkBoolOpt false "Enable networking through connman";
  };

  config = mkIf cfg.enable {
    services.connman = {
      enable = true;
      wifi.backend = "iwd";
      extraConfig = ''
        [General]
        PreferredTechnologies=ethernet,wifi
      '';

      networkInterfaceBlacklist = [ "vmnet" "vboxnet" "virbr" "ifb" "ve" ];
    };
  };
}