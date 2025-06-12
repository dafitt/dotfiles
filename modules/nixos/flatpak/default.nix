{ config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.flatpak;
in
{
  options.dafitt.flatpak = with types; {
    enable = mkEnableOption "flatpak support";
  };

  config = mkIf cfg.enable {
    services.flatpak.enable = true;

    environment.systemPackages = with pkgs; [ gnome-software ];
  };
}
