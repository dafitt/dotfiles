{ options, config, lib, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.development.direnv;
in
{
  options.custom.development.direnv = with types; {
    enable = mkBoolOpt config.custom.development.enableSuite "Enable direnv";
  };

  config = mkIf cfg.enable {
    programs.direnv.enable = true;

    #home.sessionVariables.DIRENV_LOG_FORMAT = ""; # silents direnv
  };
}
