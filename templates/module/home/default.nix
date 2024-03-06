{ config, lib, options, osConfig ? { }, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.module;
  osCfg = osConfig.custom.module or null;
in
{
  options.custom.module = with types; {
    enable = mkBoolOpt (osCfg.enable or false) "Enable module";
  };

  config = mkIf cfg.enable { };
}
