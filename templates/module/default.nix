{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.MODULE;
in
{
  options.dafitt.MODULE = with types; {
    enable = mkBoolOpt false "Whether to enable MODULE.";
  };

  config = mkIf cfg.enable { };
}
