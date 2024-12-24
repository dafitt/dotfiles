{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.hyprland.gedit;
in
{
  options.dafitt.hyprland.gedit = with types; {
    enable = mkBoolOpt false "Whether to enable gedit for hyprland.";
  };

  config = mkIf cfg.enable {
    # GNOME's former text editor
    home.packages = with pkgs; [ gedit ];

    dconf.settings = {
      "org/gnome/gedit/preferences/editor".scheme = "stylix";
    };
  };
}
