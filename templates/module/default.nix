{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.MODULE;
in
{
  options.dafitt.MODULE = with types; {
    enable = mkEnableOption "MODULE";
  };

  config = mkIf cfg.enable { };
}
