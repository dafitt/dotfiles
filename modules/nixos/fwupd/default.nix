{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.fwupd;
in
{
  options.dafitt.fwupd = with types; {
    enable = mkEnableOption "fwupd, a tool to update firmware on Linux";
  };

  config = mkIf cfg.enable {
    # To update various firmware see https://wiki.nixos.org/wiki/Fwupd
    services.fwupd.enable = true;
  };
}
