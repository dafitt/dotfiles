{ config, lib, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.environment.launchers;
in
{
  options.dafitt.environment.launchers = with types;{
    default = mkOpt (nullOr (enum [ "fuzzel" "rofi" ])) "fuzzel" "Which application launcher is to be used primarily";
  };
}
