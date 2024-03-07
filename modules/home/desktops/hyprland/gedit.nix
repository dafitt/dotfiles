{ config, lib, options, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.desktops.hyprland.gedit;
in
{
  options.custom.desktops.hyprland.gedit = with types; {
    enable = mkBoolOpt config.custom.desktops.hyprland.enable "Enable gedit for hyprland";
  };

  config = mkIf cfg.enable {
    # GNOME's former text editor
    home.packages = with pkgs; [ gedit ];

    dconf.settings = {
      "org/gnome/gedit/preferences/editor".scheme = "stylix";
    };
  };
}
