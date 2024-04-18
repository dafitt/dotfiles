{ options, config, lib, pkgs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.gaming;
  osCfg = osConfig.dafitt.gaming or null;
in
{
  options.dafitt.gaming = with types; {
    enableSuite = mkBoolOpt (osCfg.enableSuite or false) "Enable the gaming suite";
    installExtraPackages = mkBoolOpt cfg.enableSuite "Install extra gaming packages";
  };

  config = mkIf cfg.installExtraPackages {
    home.packages = with pkgs; [
    ];
  };
}
