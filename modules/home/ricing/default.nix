{ options, config, lib, pkgs, osConfig ? { }, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.ricing;
  osCfg = osConfig.custom.ricing or null;
in
{
  options.custom.ricing = with types; {
    enableSuite = mkBoolOpt (osCfg.enableSuite or false) "Enable the ricing suite";
    installExtraPackages = mkBoolOpt cfg.enableSuite "Install extra ricing packages";
  };

  config = mkIf cfg.installExtraPackages {
    home.packages = with pkgs; [
      asciiquarium # aquarium in your terminal
      cbonsai # grow bonsai trees in your terminal
      pipes # animated pipes terminal screensaver
    ];
  };
}
