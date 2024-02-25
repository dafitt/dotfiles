{ options, config, lib, ... }:

with lib;
with lib.custom;
let
  cfg = config.system.networking.networkmanager;
in
{
  # TODO check if only one network manager is enabled (mabe in system/networking/default.nix)
  options.system.networking.networkmanager = with types; {
    enable = mkBoolOpt false "Enable networking through NetworkManager";
  };

  config = mkIf cfg.enable {
    networking.networkmanager.enable = true;
  };
}
