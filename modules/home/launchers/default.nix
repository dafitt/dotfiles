{ config, lib, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.launchers;
in
{
  options.dafitt.launchers = with types;{
    default = mkOpt (nullOr (enum [ "fuzzel" "rofi" ])) "fuzzel" "Which application launcher is to be used primarily";
  };
}
