{ config, lib, pkgs, inputs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.gnome.extensions.appindicator;
in
{
  options.dafitt.gnome.extensions.appindicator = with types; {
    enable = mkEnableOption "GNOME extension 'appindicator'";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs.gnomeExtensions; [ appindicator ];

    dconf.settings = {
      "org/gnome/shell/extensions/appindicator" = {
        legacy-tray-enabled = false;
      };
    };
  };
}
