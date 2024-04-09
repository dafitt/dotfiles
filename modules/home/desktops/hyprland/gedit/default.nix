{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.desktops.hyprland.gedit;
in
{
  options.dafitt.desktops.hyprland.gedit = with types; {
    enable = mkBoolOpt config.dafitt.desktops.hyprland.enable "Enable gedit for hyprland";
  };

  config = mkIf cfg.enable {
    # GNOME's former text editor
    home.packages = with pkgs; [ gedit ];

    dconf.settings = {
      "org/gnome/gedit/preferences/editor".scheme = "stylix";
    };
  };
}
