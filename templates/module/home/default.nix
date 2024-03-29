{ options, config, lib, pkgs, osConfig ? { }, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.MODULE;
  osCfg = osConfig.custom.MODULE or null;
in
{
  options.custom.MODULE = with types; {
    enable = mkBoolOpt (osCfg.enable or false) "Enable MODULE";
  };

  config = mkIf cfg.enable { };
}
