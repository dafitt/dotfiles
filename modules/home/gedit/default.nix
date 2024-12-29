{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.gedit;
in
{
  options.dafitt.gedit = with types; {
    enable = mkEnableOption "gedit";
  };

  config = mkIf cfg.enable {
    # GNOME's former text editor
    home.packages = with pkgs; [ gedit ];

    dconf.settings = {
      "org/gnome/gedit/preferences/editor".scheme = "stylix";
    };
  };
}
