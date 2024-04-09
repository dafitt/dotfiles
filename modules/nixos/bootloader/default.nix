{ config, lib, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.bootloader;
  enabledSubModules = filterAttrs (_: v: v.enable) cfg;
  enabledSubModulesNames = concatStringsSep ", " (attrNames enabledSubModules);
in
{
  config = {
    assertions = [
      {
        assertion = length (attrNames enabledSubModules) <= 1;
        message = "Only one module for system.bootloader can be enabled. Currently enabled: ${enabledSubModulesNames}";
      }
    ];
  };
}
