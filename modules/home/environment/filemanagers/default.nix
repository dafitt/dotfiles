{ config, lib, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.environment.filemanagers;
in
{
  options.dafitt.environment.filemanagers = with types;{
    default = mkOpt (nullOr (enum [ "nautilus" "pcmanfm" "yazi" ])) "nautilus" "Which file manager is to be used primarily.";
    autostart = mkBoolOpt true "Start the filemanager on login.";
  };
}
