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

      # [fix for flatpak open URLs with default browser](https://discourse.nixos.org/t/open-links-from-flatpak-via-host-firefox/15465/11)
      # [Clicked links in desktop apps not opening browers](https://discourse.nixos.org/t/clicked-links-in-desktop-apps-not-opening-browers/29114/28?u=digitalrobot)
      config.common.default = [ "gnome" ];

      # fix file chooser on hyprland https://wiki.hyprland.org/useful-utilities/xdg-desktop-portal-hyprland/
      config.hyprland = {
        default = [ "hyprland" "gtk" ];
        "org.freedesktop.impl.portal.FileChooser" = "gtk";
      };
    };
  };
}
