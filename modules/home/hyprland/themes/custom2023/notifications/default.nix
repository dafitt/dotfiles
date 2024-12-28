{ options, config, lib, ... }:

with lib;
let
  cfg = config.dafitt.hyprland.themes.custom2023.notifications;
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
