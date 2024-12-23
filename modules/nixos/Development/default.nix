{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.Development;
in
{
  options.dafitt.Development = with types; {
    enableSuite = mkBoolOpt false "Whether to enable the Development suite.";
  };
}
