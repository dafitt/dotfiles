{ config, lib, options, osConfig ? { }, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.editing;
  osCfg = osConfig.custom.editing or null;
in
{
  options.custom.editing = with types; {
    enableSuite = mkBoolOpt (osCfg.enableSuite or false) "Enable the full editing suite";
    installExtraPackages = mkBoolOpt cfg.enableSuite "Install extra editing packages";
  };

  config = mkIf cfg.installExtraPackages {
    home.packages = with pkgs; [
      tenacity # Sound editor with graphical UI
    ];
  };
}
