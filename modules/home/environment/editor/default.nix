{ config, lib, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.editor;
in
{
  options.dafitt.editor = with types;{
    default = mkOpt (nullOr (enum [ "micro" ])) "micro" "Which terminal editor to use";
  };

  config = { };
}
