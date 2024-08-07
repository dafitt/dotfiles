{ options, config, lib, pkgs, inputs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.desktops.gnome.extensions.all-windows-srwp;
in
{
  options.dafitt.desktops.gnome.extensions.all-windows-srwp = with types; {
    enable = mkBoolOpt config.dafitt.desktops.gnome.extensions.enable "Enable Gnome extension 'all-windows-srwp'.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs.gnomeExtensions; [ ];

    dconf.settings = {
      "org/gnome/shell" = {
        enabled-extensions = [ "all-windows-srwp@jkavery.github.io" ];
      };
    };
  };
}
