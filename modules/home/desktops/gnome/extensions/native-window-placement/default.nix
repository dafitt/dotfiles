{ options, config, lib, pkgs, inputs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.desktops.gnome.extensions.native-window-placement;
in
{
  options.dafitt.desktops.gnome.extensions.native-window-placement = with types; {
    enable = mkBoolOpt config.dafitt.desktops.gnome.extensions.enable "Whether to enable Gnome extension 'native-window-placement'.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs.gnomeExtensions; [ ];

    dconf.settings = { };
  };
}
