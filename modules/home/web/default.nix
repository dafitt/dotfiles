{ options, config, lib, pkgs, osConfig ? { }, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.web;
  osCfg = osConfig.custom.web or null;
in
{
  options.custom.web = with types; {
    enableSuite = mkBoolOpt (osCfg.enableSuite or true) "Enable the web suite";
    installExtraPackages = mkBoolOpt cfg.enableSuite "Install extra web packages";
  };

  config = mkIf cfg.installExtraPackages {
    home.packages = with pkgs; [
    ];
  };
}
