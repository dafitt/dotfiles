{
  config,
  lib,
  pkgs,
  osConfig ? { },
  ...
}:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.nushell;
  osCfg = osConfig.dafitt.nushell or null;
in
{
  options.dafitt.nushell = with types; {
    enable = mkBoolOpt (osCfg.enable or false) "Whether to enable the nu shell.";
  };

  config = mkIf cfg.enable {
    # A new type of shell
    # https://www.nushell.sh/
    # https://github.com/nushell/nushell
    programs.nushell = {
      enable = true;
    };
  };
}
