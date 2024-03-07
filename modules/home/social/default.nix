{ config, lib, options, osConfig ? { }, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.social;
  osCfg = osConfig.custom.social or null;
in
{
  options.custom.social = with types; {
    enableSuite = mkBoolOpt (osCfg.enableSuite or false) "Enable the full social suite";
    installExtraPackages = mkBoolOpt cfg.enableSuite "Install extra social packages";
  };

  config = mkIf cfg.installExtraPackages {
    home.packages = with pkgs; [
      signal-desktop
    ];
  };
}
