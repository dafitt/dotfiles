{ options, config, lib, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.features.steam;
in
{
  options.custom.features.steam = with types; {
    enable = mkBoolOpt false "Enable steam";
  };

  config = mkIf cfg.enable {
    programs.steam.enable = true;

    services.udev.extraRules = ''
      ATTR{power/control}="on"
    '';
  };
}
