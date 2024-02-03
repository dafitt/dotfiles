{ lib, pkgs, ... }: rec {

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

  home.packages = [ pkgs.libsForQt5.qt5ct ];

  services.xsettingsd = {
    enable = true;
    settings = {
      "Net/ThemeName" = gtk.theme.name;
      "Net/IconThemeName" = gtk.iconTheme.name;
    };
  };
}
