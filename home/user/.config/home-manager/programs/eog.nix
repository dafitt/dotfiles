{ config, lib, pkgs, ... }: {

  # GNOME image viewer
  home.packages = [ pkgs.gnome.eog ];

  dconf.settings = {
    "org/gnome/eog/ui" = {
      statusbar = true;
    };
    "org/gnome/eog/view" = {
      transparency = "background";
    };
    "org/gnome/eog/plugins" = {
      active-plugins = [ "reload" "fullscreen" ];
    };
  };
}
