{ options, config, lib, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.MODULE;
in
{
  options.custom.MODULE = with types; {
    enable = mkBoolOpt false "Enable MODULE";
  };

  config = mkIf cfg.enable { };
}
