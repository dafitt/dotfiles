{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.networking;
  enabledSubModules = filter (n: cfg.${n}.enable or false) (attrNames cfg);
in
{
  config = {
    assertions = [{
      assertion = length enabledSubModules <= 1;
      message = "${toString ./.}: Only one submodule can be enabled. Currently enabled: ${concatStringsSep ", " enabledSubModules}";
    }];
  };
}
