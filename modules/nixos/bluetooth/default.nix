{ config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.bluetooth;
in
{
  options.dafitt.bluetooth = with types; {
    enable = mkEnableOption "bluetooth";
  };

  config = mkIf cfg.enable {
    hardware.bluetooth.enable = true;

    # GUI
    environment.systemPackages = with pkgs; [ overskride ];
  };
}
