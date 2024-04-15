{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.networking;
  enabledSubModules = builtins.attrNames cfg;
  enabledSubModulesNames = lib.filter (name: cfg.${name}.enable or false) networkManagers;
in
{
  options.dafitt.networking = with types; {
    enable = mkOpt (nullOr (enum [ "connman" "networkmanager" ])) "networkmanager" "Which network manager to use";
  };

  assertions = [{
    assertion = length enabledNetworkManagers <= 1;
    message = "Only one module for networking can be enabled. Currently enabled: ${enabledSubModulesNames}";
  }];
}
