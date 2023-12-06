{ config, lib, pkgs, ... }: {

  # GNOME's former text editor
  home.packages = [ pkgs.gedit ];

  dconf.settings = {
    "org/gnome/gedit/preferences/editor".scheme = "stylix";
  };
}
