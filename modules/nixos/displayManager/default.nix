{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.displayManager;
  enabledSubModules = filter (n: cfg.${n}.enable or false) (attrNames cfg);
in
{
  options.dafitt.displayManager = with types; {
    enable = mkOpt (nullOr (enum [ "gdm" "greetd" ])) "gdm" "Which display/login manager to use.";
  };

  config = {
    assertions = [{
      assertion = length enabledSubModules <= 1;
      message = "${toString ./.}: Only one submodule can be enabled. Currently enabled: ${concatStringsSep ", " enabledSubModules}";
    }];
  };
}
