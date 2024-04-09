{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.networking.networkmanager;
in
{
  options.dafitt.networking.networkmanager = with types; {
    enable = mkBoolOpt false "Enable networking through NetworkManager";
  };

  config = mkIf cfg.enable {
    networking.networkmanager.enable = true;
  };
}
