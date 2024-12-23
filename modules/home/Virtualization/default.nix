{ options, config, lib, pkgs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.Virtualization;
  osCfg = osConfig.dafitt.Virtualization or null;
in
{
  options.dafitt.Virtualization = with types; {
    enableSuite = mkBoolOpt (osCfg.enableSuite or false) "Whether to enable the Virtualization suite.";
  };

  config = mkIf cfg.enableSuite {
    home.packages = with pkgs; [
      bottles # run Windows software on Linux
    ];
  };
}
