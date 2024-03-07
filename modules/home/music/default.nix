{ config, lib, options, osConfig ? { }, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.music;
  osCfg = osConfig.custom.music or null;
in
{
  options.custom.music = with types; {
    enableSuite = mkBoolOpt (osCfg.enableSuite or false) "Enable the full music suite";
    installExtraPackages = mkBoolOpt cfg.enableSuite "Install extra music packages";
  };

  config = mkIf cfg.installExtraPackages {
    home.packages = with pkgs; [ ];
  };
}
