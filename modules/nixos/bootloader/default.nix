{ config, lib, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.bootloader;
  enabledSubModules = filterAttrs (_: v: v.enable) cfg;
  enabledSubModulesNames = concatStringsSep ", " (attrNames enabledSubModules);
in
{
  options.dafitt.bootloader = with types; {
    enable = mkOpt (nullOr (enum [ "grub" "systemd-boot" ])) "systemd-boot" "Which bootloader to use";
  };

  config = {
    assertions = [{
      assertion = length (attrNames enabledSubModules) <= 1;
      message = "Only one module for bootloader can be enabled. Currently enabled: ${enabledSubModulesNames}";
    }];
  };
}
