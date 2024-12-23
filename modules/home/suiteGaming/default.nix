{ options, config, lib, pkgs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.Gaming;
  osCfg = osConfig.dafitt.Gaming or null;
in
{
  options.dafitt.Gaming = with types; {
    enable = mkBoolOpt (osCfg.enable or false) "Whether to enable the Gaming suite.";
  };

  config = mkIf cfg.enable {
    dafitt = {
      steam.enable = true;
    };
  };
}
