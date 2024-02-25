{ options, config, lib, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.features.fstrim;
in
{
  options.features.fstrim = with types; {
    enable = mkBoolOpt true "Enable fstrim, a utility to trim unused blocks on a filesystem periodically";
  };

  config = mkIf cfg.enable {
    services.fstrim.enable = true;
  };
}
