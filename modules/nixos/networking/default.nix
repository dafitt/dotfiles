{ options, config, lib, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.networking;
  networkManagers = builtins.attrNames cfg;
  enabledNetworkManagers = lib.filter (name: cfg.${name}.enable or false) networkManagers;
in
{
  assertions = [{
    assertion = length enabledNetworkManagers <= 1;
    message = "Only one network manager can be enabled at a time.";
  }];
}
