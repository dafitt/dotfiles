{ config, lib, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.editors;
in
{
  options.dafitt.editors = with types;{
    default = mkOption {
      type = nullOr (enum [ "micro" ]);
      default = null;
      description = "Which terminal editor is to be used primarily.";
    };
  };
}
