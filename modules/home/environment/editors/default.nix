{ config, lib, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.environment.editors;
in
{
  options.dafitt.environment.editors = with types;{
    default = mkOpt (nullOr (enum [ "micro" ])) "micro" "Which terminal editor is to be used primarily";
  };
}
