{ options, config, lib, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.gaming;
in
{
  options.custom.gaming = with types; {
    enableSuite = mkBoolOpt false "Enable the full gaming suite";
  };
}
