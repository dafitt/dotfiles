{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.displayManager;
  enabledSubModules = builtins.attrNames cfg;
  enabledSubModulesNames = lib.filter (name: cfg.${name}.enable or false) networkManagers;
in
{
  options.dafitt.displayManager = with types; {
    enable = mkOpt (nullOr (enum [ "gdm" "greetd" ])) "greetd" "Which display/login manager to use";
  };

  assertions = [{
    assertion = length enabledNetworkManagers <= 1;
    message = "Only one module for displayManager can be enabled. Currently enabled: ${enabledSubModulesNames}";
  }];
}
