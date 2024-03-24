{ options, config, lib, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.gaming.steam;
in
{
  options.custom.gaming.steam = with types; {
    enable = mkBoolOpt config.custom.gaming.enableSuite "Enable steam optimization";
  };

  config = mkIf cfg.enable {
    services.udev.extraRules = ''
      ATTR{power/control}="on"
    '';
  };
}
