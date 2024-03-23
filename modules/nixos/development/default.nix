{ options, config, lib, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.development;
in
{
  options.custom.development = with types; {
    enableSuite = mkBoolOpt false "Enable the development suite";
  };
}
