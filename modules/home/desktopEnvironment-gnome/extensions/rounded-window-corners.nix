{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dafitt.gnome.extensions.rounded-window-corners;
in
{
  options.dafitt.gnome.extensions.rounded-window-corners = {
    enable = mkEnableOption "GNOME extension 'rounded-window-corners'";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs.gnomeExtensions; [ rounded-window-corners-reborn ];

    dconf.settings = { };
  };
}
