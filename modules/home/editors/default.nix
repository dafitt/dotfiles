{ config, lib, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.editors;
in
{
  options.dafitt.editors = with types;{
    default = mkOpt (nullOr (enum [ "micro" ])) "micro" "Which terminal editor is to be used primarily";
  };
}
