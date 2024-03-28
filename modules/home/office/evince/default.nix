{ options, config, lib, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.office.evince;
in
{
  options.custom.office.evince = with types; {
    enable = mkBoolOpt config.custom.office.enableSuite "Enable evince";
    defaultApplication = mkBoolOpt true "Set evince as the default application for its mimetypes";
  };

  config = mkIf cfg.enable {
    # GNOME's document viewer
    home.packages = with pkgs; [ evince ];

    xdg.mimeApps.defaultApplications = mkIf cfg.defaultApplication (listToAttrs (map (mimeType: { name = mimeType; value = [ "org.gnome.Evince.desktop" ]; }) [
      "application/illustrator"
      "application/oxps"
      "application/pdf"
      "application/postscript"
      "application/vnd.comicbook+zip"
      "application/vnd.comicbook-rar"
      "application/vnd.ms-xpsdocument"
      "application/x-bzdvi"
      "application/x-bzpdf"
      "application/x-bzpostscript"
      "application/x-cb7"
      "application/x-cbr"
      "application/x-cbt"
      "application/x-cbz"
      "application/x-dvi"
      "application/x-ext-cb7"
      "application/x-ext-cbr"
      "application/x-ext-cbt"
      "application/x-ext-cbz"
      "application/x-ext-djv"
      "application/x-ext-djvu"
      "application/x-ext-dvi"
      "application/x-ext-eps"
      "application/x-ext-pdf"
      "application/x-ext-ps"
      "application/x-gzdvi"
      "application/x-gzpdf"
      "application/x-gzpostscript"
      "application/x-xzpdf"
      "application/x-xz"
      "application/x-zip"
      "application/x-zip-compressed"
      "application/zip"
      "image/tiff"
      "image/vnd.djvu+multipage"
      "image/x-bzeps"
      "image/x-eps"
      "image/x-gzeps"
    ]));
  };
}
