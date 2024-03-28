{ options, config, lib, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.networking.networkmanager;
in
{
  options.custom.networking.networkmanager = with types; {
    enable = mkBoolOpt false "Enable networking through NetworkManager";
  };

  config = mkIf cfg.enable {
    networking.networkmanager.enable = true;
  };
}
