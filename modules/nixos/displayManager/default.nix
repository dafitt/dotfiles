{
  config,
  lib,
  ...
}:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.displayManager;
  enabledSubModules = filter (n: cfg.${n}.enable or false) (attrNames cfg);
in
{
  config = mkMerge [
    {
      assertions = [
        {
          assertion = length enabledSubModules <= 1;
          message = "${toString ./.}: Only one submodule can be enabled. Currently enabled: ${concatStringsSep ", " enabledSubModules}";
        }
      ];
    }
  ];
}
