{ options, config, lib, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.networking.networkmanager;
in
{
  # TODO: check if only one network manager is enabled (mabe in system/networking/default.nix)
  options.custom.networking.networkmanager = with types; {
    enable = mkBoolOpt false "Enable networking through NetworkManager";
  };

  config = mkIf cfg.enable {
    networking.networkmanager.enable = true;
  };
}