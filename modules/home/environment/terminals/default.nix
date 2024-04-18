{ config, lib, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.environment.terminals;
in
{
  options.dafitt.environment.terminals = with types;{
    default = mkOpt (enum [ "kitty" ]) "kitty" "Which terminal emulator is to be used primarily"; # at least one terminal should always be enabled
  };
}
