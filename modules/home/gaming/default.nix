{ options, config, lib, pkgs, osConfig ? { }, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.gaming;
  osCfg = osConfig.custom.gaming or null;
in
{
  options.custom.gaming = with types; {
    enableSuite = mkBoolOpt (osCfg.enableSuite or false) "Enable the gaming suite";
    installExtraPackages = mkBoolOpt cfg.enableSuite "Install extra gaming packages";
  };

  config = mkIf cfg.installExtraPackages {
    home.packages = with pkgs; [
      ludusavi # Savegame manager
    ];
  };
}
