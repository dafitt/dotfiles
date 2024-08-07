{ options, config, lib, pkgs, inputs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.desktops.gnome.extensions.vitals;
in
{
  options.dafitt.desktops.gnome.extensions.vitals = with types; {
    enable = mkBoolOpt config.dafitt.desktops.gnome.extensions.enable "Enable Gnome extension 'vitals'.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs.gnomeExtensions; [ vitals ];

    dconf.settings = {
      "org/gnome/shell" = {
        enabled-extensions = [ "Vitals@CoreCoding.com" ];
      };
    };
  };
}
