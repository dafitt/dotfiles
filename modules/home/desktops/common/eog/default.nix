{ options, config, lib, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.desktops.common.eog;
in
{
  options.custom.desktops.common.eog = with types; {
    enable = mkBoolOpt config.custom.desktops.common.enable "Enable eog image viewer";
    defaultApplication = mkBoolOpt true "Set eog as the default application for its mimetypes";
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

    xdg.mimeApps.defaultApplications = mkIf cfg.defaultApplication (listToAttrs (map (mimeType: { name = mimeType; value = [ "org.gnome.eog.desktop" ]; }) [
      "image/bmp"
      "image/gif"
      "image/jpeg"
      "image/png"
      "image/svg+xml"
      "image/tiff"
      "image/x-xcf"
      "image/x-icns"
      "image/x-psd"
      "image/x-tga"
      "image/x-pcx"
      "image/vnd.djvu"
      "image/vnd.microsoft.icon"
      "image/vnd.wap.wbmp"
      "image/vnd.xiff"
    ]));
  };
}
