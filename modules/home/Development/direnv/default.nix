{ options, config, lib, pkgs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.Development.direnv;
  osCfg = osConfig.dafitt.Development.direnv or null;
in
{
  options.dafitt.Development.direnv = with types; {
    enable = mkBoolOpt (!osCfg.enable or config.dafitt.Development.enableSuite) "Enable direnv.";
  };

  config = mkIf cfg.enable {
    programs.direnv.enable = true;
    home.sessionVariables.DIRENV_LOG_FORMAT = ""; # silents direnv
  };
}
