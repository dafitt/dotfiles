{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.flatpak;
in
{
  options.dafitt.flatpak = with types; {
    enable = mkBoolOpt false "Enable flatpak support";
  };

  config = mkIf cfg.enable {
    services.flatpak.enable = true;

    environment.systemPackages = with pkgs; [ gnome.gnome-software ];

    xdg.portal = {
      enable = true;
      extraPortals = mkIf (!config.services.xserver.desktopManager.gnome.enable) [ pkgs.xdg-desktop-portal-gtk ];
      config.common.default = [ "gtk" "gnome" ];
    };
  };
}
