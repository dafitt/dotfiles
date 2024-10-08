{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.shells;
  enabledSubModules = filter (n: cfg.${n}.enable or false) (attrNames cfg);
in
{
  options.dafitt.shells = with types; {
    default = mkOpt (nullOr (enum [ "bash" "fish" ])) "fish" "Which default shell to set.";
  };
}
