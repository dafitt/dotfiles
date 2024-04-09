{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.gaming.steam;
in
{
  options.dafitt.gaming.steam = with types; {
    enable = mkBoolOpt config.dafitt.gaming.enableSuite "Enable steam optimization";
  };

  config = mkIf cfg.enable {
    services.udev.extraRules = ''
      ATTR{power/control}="on"
    '';
  };
}
