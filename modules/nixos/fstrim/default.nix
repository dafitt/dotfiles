{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.fstrim;
in
{
  options.dafitt.fstrim = with types; {
    enable = mkBoolOpt true "Enable fstrim, a utility to trim unused blocks on a filesystem periodically.";
  };

  config = mkIf cfg.enable {
    services.fstrim.enable = true;
  };
}
