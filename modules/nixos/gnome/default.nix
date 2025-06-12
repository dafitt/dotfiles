{ config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.gnome;
in
{
  options.dafitt.gnome = with types; {
    enable = mkEnableOption "the GNOME desktop environment";
  };

  config = mkIf cfg.enable {
    services.xserver.desktopManager.gnome.enable = true;
    services.udev.packages = [ pkgs.gnome-settings-daemon ];
  };
}
