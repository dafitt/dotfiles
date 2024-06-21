{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.systemd;
in
{
  options.dafitt.systemd = with types; {
    enable = mkBoolOpt true "Enable systemd configuration.";
  };

  config = mkIf cfg.enable {

    services.journald.extraConfig = ''
      SystemMaxUse=100M
      MaxFileSec=7day
    '';
  };
}
