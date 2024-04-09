{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.development.direnv;
in
{
  options.dafitt.development.direnv = with types; {
    enable = mkBoolOpt config.dafitt.development.enableSuite "Enable direnv";
  };

  config = mkIf cfg.enable {
    programs.direnv.enable = true;
    programs.direnv.silent = true;
  };
}
