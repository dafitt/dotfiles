{ options, config, lib, pkgs, inputs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.desktops.gnome.extensions.system-monitor;
in
{
  options.dafitt.desktops.gnome.extensions.system-monitor = with types; {
    enable = mkBoolOpt config.dafitt.desktops.gnome.extensions.enable "Enable Gnome extension 'system-monitor'.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs.gnomeExtensions; [ ];

    dconf.settings = {
      "org/gnome/shell" = {
        enabled-extensions = [ "system-monitor@gnome-shell-extensions.gcampax.github.com" ];
      };
    };
  };
}
