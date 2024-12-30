{ config, lib, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.filemanagers;
in
{
  options.dafitt.filemanagers = with types;{
    autostart = mkBoolOpt true "Start the filemanager on login.";

    default = mkOption {
      type = nullOr (enum [ "nautilus" "pcmanfm" "yazi" ]);
      default = null;
      description = "Which file manager will be used primarily.";
    };
  };
}
