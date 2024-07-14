{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.Gaming.ratbagd;
in
{
  options.dafitt.Gaming.ratbagd = with types; {
    enable = mkBoolOpt config.dafitt.Gaming.enableSuite "Enable ratbagd, a DBus daemon to configure gaming mice.";
  };

  config = mkIf cfg.enable {
    services.ratbagd.enable = true;

    # GUI
    environment.systemPackages = with pkgs; [ piper ];
  };
}
