{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.time;
in
{
  options.dafitt.time = with types; {
    enable = mkEnableOption "configuring timezone";
  };

  config = mkIf cfg.enable {
    time.timeZone = "Europe/Berlin";
  };
}
