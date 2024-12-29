{ options, config, lib, pkgs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.MODULE;
  osCfg = osConfig.dafitt.MODULE or null;
in
{
  options.dafitt.MODULE = with types; {
    enable = mkBoolOpt (osCfg.enable or false) "Whether to enable MODULE.";
    #enable = mkEnableOption "MODULE";
  };

  config = mkIf cfg.enable { };
}
