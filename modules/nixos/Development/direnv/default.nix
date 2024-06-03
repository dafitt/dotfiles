{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.Development.direnv;
in
{
  options.dafitt.Development.direnv = with types; {
    enable = mkBoolOpt config.dafitt.Development.enableSuite "Enable direnv.";
  };

  config = mkIf cfg.enable {
    programs.direnv.enable = true;
    programs.direnv.silent = true;
  };
}
