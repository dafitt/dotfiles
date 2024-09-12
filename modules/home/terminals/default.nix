{ config, lib, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.terminals;
in
{
  options.dafitt.terminals = with types;{
    default = mkOpt (enum [ "kitty" ]) "kitty" "Which terminal emulator is to be used primarily"; # at least one terminal should always be enabled
  };
}
