{ options, config, lib, pkgs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.virtualizaion;
  osCfg = osConfig.dafitt.virtualizaion or null;
in
{
  options.dafitt.virtualizaion = with types; {
    enableSuite = mkBoolOpt (osCfg.enableSuite or false) "Enable the virtualizaion suite";
  };

  config = mkIf cfg.enableSuite {
    home.packages = with pkgs; [
      bottles # run Windows software on Linux
    ];
  };
}
