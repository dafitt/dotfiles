{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dafitt.gnome.extensions.vitals;
in
{
  options.dafitt.gnome.extensions.vitals = {
    enable = mkEnableOption "GNOME extension 'vitals'";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs.gnomeExtensions; [ vitals ];

    dconf.settings = {
      "org/gnome/shell/extensions/vitals" = {
        icon-style = 1; # GNOME
        update-time = 3;
        menu-centered = true;
      };
    };
  };
}
