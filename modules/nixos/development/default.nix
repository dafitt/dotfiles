{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.development;
in
{
  options.dafitt.development = with types; {
    enableSuite = mkBoolOpt false "Enable the development suite";
  };
}
