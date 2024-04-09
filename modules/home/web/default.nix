{ options, config, lib, pkgs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.web;
  osCfg = osConfig.dafitt.web or null;
in
{
  options.dafitt.web = with types; {
    enableSuite = mkBoolOpt (osCfg.enableSuite or true) "Enable the web suite";
    installExtraPackages = mkBoolOpt cfg.enableSuite "Install extra web packages";
  };

  config = mkIf cfg.installExtraPackages {
    home.packages = with pkgs; [
    ];
  };
}
