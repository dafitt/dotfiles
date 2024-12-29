{ config, lib, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.launchers;
in
{
  options.dafitt.launchers = with types;{
    default = mkOption {
      type = nullOr (enum [ "fuzzel" "rofi" ]);
      default = null;
      description = "Which application launcher is to be used primarily.";
    };
  };
}
