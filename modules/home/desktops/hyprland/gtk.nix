{ config, lib, options, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.desktops.hyprland.gtk;
in
{
  options.custom.desktops.hyprland.gtk = with types; {
    enable = mkBoolOpt config.custom.desktops.hyprland.enable "Enable gtk configuration for hyprland";
  };

  config = mkIf cfg.enable {
    gtk = {
      theme = {
        name = lib.mkForce "adw-gtk3-dark"; # dark theme
        #package = lib.mkForce pkgs.orchis-theme;
      };
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme.override {
          color = "black";
        };
      };
      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
        gtk-primary-button-warps-slider = true;
      };
      gtk4.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };

    qt = {
      enable = true;
      platformTheme = "gnome";
      style = {
        name = "adwaita-dark";
        package = pkgs.adwaita-qt;
      };
    };

    home.packages = with pkgs; [ libsForQt5.qt5ct ];

    services.xsettingsd = {
      enable = true;
      settings = {
        "Net/ThemeName" = gtk.theme.name;
        "Net/IconThemeName" = gtk.iconTheme.name;
      };
    };
  };
}
