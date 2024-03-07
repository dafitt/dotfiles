{ config, lib, options, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.desktops.common.eog;
in
{
  options.custom.desktops.common.eog = with types; {
    enable = mkBoolOpt config.custom.desktops.common.enable "Enable 'eye of gnome' image viewer";
  };

  config = mkIf cfg.enable {
    # GNOME image viewer
    home.packages = with pkgs; [ gnome.eog ];

    dconf.settings = {
      "org/gnome/eog/ui" = {
        statusbar = true;
      };
      "org/gnome/eog/view" = {
        transparency = "background";
      };
      "org/gnome/eog/plugins" = {
        active-plugins = [ "reload" "fullscreen" ];
      };
    };
  };
}
