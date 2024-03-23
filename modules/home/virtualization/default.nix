{ options, config, lib, pkgs, osConfig ? { }, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.virtualizaion;
  osCfg = osConfig.custom.virtualizaion or null;
in
{
  options.custom.virtualizaion = with types; {
    enableSuite = mkBoolOpt (osCfg.enableSuite or false) "Enable the virtualizaion suite";
    installExtraPackages = mkBoolOpt cfg.enableSuite "Install extra virtualizaion packages";
  };

  config = mkIf cfg.installExtraPackages {
    home.packages = with pkgs; [
      bottles # run Windows software on Linux
    ];
  };
}
