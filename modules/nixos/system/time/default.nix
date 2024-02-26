{ options, config, lib, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.system.time;
in
{
  options.custom.system.time = with types; {
    enable = mkBoolOpt true "Whether or not to configure timezone information.";
  };

  config = mkIf cfg.enable {
    time.timeZone = "Europe/Berlin";
  };
}
