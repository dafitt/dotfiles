{ config, lib, ... }:

with lib;
let
  cfg = config.dafitt.desktopEnvironment-hyprland.themes;
  enabledSubModules = filter (n: cfg.${n}.enable or false) (attrNames cfg);
in
{
  imports = [
    themes/hyprpanel/default.nix
  ];

  config = {
    assertions = [
      {
        assertion = length enabledSubModules <= 1;
        message = "${toString ./.}: Only one submodule can be enabled. Currently enabled: ${concatStringsSep ", " enabledSubModules}";
      }
    ];
  };
}
