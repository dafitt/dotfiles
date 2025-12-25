{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dafitt.gnome.extensions.appindicator;
in
{
  options.dafitt.gnome.extensions.appindicator = {
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
