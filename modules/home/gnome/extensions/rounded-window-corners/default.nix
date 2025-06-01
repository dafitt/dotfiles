{ config, lib, pkgs, inputs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.gnome.extensions.rounded-window-corners;
in
{
  options.dafitt.gnome.extensions.rounded-window-corners = with types; {
    enable = mkEnableOption "GNOME extension 'rounded-window-corners'";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs.gnomeExtensions; [ rounded-window-corners-reborn ];

    dconf.settings = { };
  };
}
