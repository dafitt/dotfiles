{ options, config, lib, pkgs, inputs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.desktops.gnome.extensions.appindicator;
in
{
  options.dafitt.desktops.gnome.extensions.appindicator = with types; {
    enable = mkBoolOpt config.dafitt.desktops.gnome.extensions.enable "Whether to enable Gnome extension 'appindicator'.";
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
