{ options, config, lib, pkgs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.ricing;
  osCfg = osConfig.dafitt.ricing or null;
in
{
  options.dafitt.ricing = with types; {
    enableSuite = mkBoolOpt (osCfg.enableSuite or false) "Enable the ricing suite";
    installExtraPackages = mkBoolOpt cfg.enableSuite "Install extra ricing packages";
  };

  config = mkIf cfg.installExtraPackages {
    home.packages = with pkgs; [
      asciiquarium # aquarium in your terminal
      cbonsai # grow bonsai trees in your terminal
      peaclock # a text-based clock
      pipes # animated pipes terminal screensaver
    ];
  };
}
