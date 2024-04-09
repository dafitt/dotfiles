{ options, config, lib, pkgs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.development.direnv;
  osCfg = osConfig.dafitt.development.direnv or null;
in
{
  options.dafitt.development.direnv = with types; {
    enable = mkBoolOpt (!osCfg.enable or config.dafitt.development.enableSuite) "Enable direnv";
  };

  config = mkIf cfg.enable {
    programs.direnv.enable = true;
    home.sessionVariables.DIRENV_LOG_FORMAT = ""; # silents direnv
  };
}
