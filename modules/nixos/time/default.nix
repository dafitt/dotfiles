{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.time;
in
{
  options.dafitt.time = with types; {
    enable = mkEnableOption "timezone configuration";
  };

  config = mkIf cfg.enable {
    time.timeZone = "Europe/Berlin";
  };
}
