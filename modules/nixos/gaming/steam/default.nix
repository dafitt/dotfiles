{ options, config, lib, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.gaming.steam;
in
{
  options.custom.gaming.steam = with types; {
    enable = mkBoolOpt false "Enable steam";
  };

  config = mkIf cfg.enable {
    programs.steam = {
      enable = true;
      gamescopeSession = {
        enable = true;
        args = [ "--immediate-flips" ];
      };
    };

    services.udev.extraRules = ''
      ATTR{power/control}="on"
    '';
  };
}
