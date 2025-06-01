{ config, lib, pkgs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.suiteGaming;
  osCfg = osConfig.dafitt.suiteGaming or null;
in
{
  options.dafitt.suiteGaming = with types; {
    enable = mkBoolOpt (osCfg.enable or false) "Whether to enable the Gaming suite.";
  };

  config = mkIf cfg.enable {
    dafitt = {
      steam.enable = true;
    };
  };
}
