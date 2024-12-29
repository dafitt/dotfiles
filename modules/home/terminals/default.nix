{ config, lib, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.terminals;
in
{
  options.dafitt.terminals = with types;{
    default = mkOption {
      type = nullOr (enum [ "kitty" ]);
      default = null;
      description = "Which terminal emulator is to be used primarily.";
    };
  };
}
