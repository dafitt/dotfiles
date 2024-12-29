{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.eog;
in
{
  options.dafitt.eog = with types; {
    enable = mkEnableOption "eog image viewer";
    defaultApplication = mkBoolOpt true "Set eog as the default application for its mimetypes.";
  };

  config = mkIf cfg.enable {
    # GNOME image viewer
    home.packages = with pkgs; [ eog ];

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
