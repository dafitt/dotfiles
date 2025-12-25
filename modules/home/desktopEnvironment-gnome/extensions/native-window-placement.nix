{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dafitt.gnome.extensions.native-window-placement;
in
{
  options.dafitt.gnome.extensions.native-window-placement = {
    enable = mkEnableOption "GNOME extension 'native-window-placement'";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs.gnomeExtensions; [ ];

    dconf.settings = { };
  };
}
