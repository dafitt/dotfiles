{ options, config, lib, pkgs, osConfig ? { }, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.development.direnv;
  osCfg = osConfig.custom.development.direnv or null;
in
{
  options.custom.development.direnv = with types; {
    enable = mkBoolOpt (!osCfg.enable or config.custom.development.enableSuite) "Enable direnv";
  };

  config = mkIf cfg.enable {
    programs.direnv.enable = true;
    home.sessionVariables.DIRENV_LOG_FORMAT = ""; # silents direnv
  };
}