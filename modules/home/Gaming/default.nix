{ options, config, lib, pkgs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.Gaming;
  osCfg = osConfig.dafitt.Gaming or null;
in
{
  options.dafitt.Gaming = with types; {
    enableSuite = mkBoolOpt (osCfg.enableSuite or false) "Enable the Gaming suite.";
  };

  config = mkIf cfg.enableSuite {
    home.packages = with pkgs; [
    ];
  };
}
