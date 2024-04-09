{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.desktops.common.file-roller;
in
{
  options.dafitt.desktops.common.file-roller = with types; {
    enable = mkBoolOpt config.dafitt.desktops.common.enable "Enable the file-roller archive manager";
    defaultApplication = mkBoolOpt true "Set file-roller as the default application for its mimetypes";

  };

  config = mkIf cfg.enable {
    # GNOME's archive manager
    home.packages = with pkgs; [ gnome.file-roller ];

    xdg.mimeApps.defaultApplications = mkIf cfg.defaultApplication (listToAttrs (map (mimeType: { name = mimeType; value = [ "org.gnome.FileRoller.desktop" ]; }) [
      "application/arj"
      "application/bz2"
      "application/bzip2"
      "application/x-bzip2"
      "application/x-compress"
      "application/x-gzip"
      "application/x-tar"
      "application/zip"
      "application/x-zip"
      "application/x-7z-compressed"
      "application/x-rar"
      "application/x-rar-compressed"
      "application/x-tar"
      "application/x-gtar"
      "application/x-ustar"
      "application/x-cpio"
      "application/x-shar"
      "application/x-lha"
      "application/x-lzh"
      "application/x-lzma"
      "application/x-lzop"
      "application/x-war"
      "application/x-java-archive"
      "application/x-deb"
      "application/x-rpm"
      "application/x-iso9660-image"
      "application/x-ms-installer"
      "application/x-msi"
      "application/x-apple-diskimage"
      "application/x-apple-disk-image"
      "application/x-xz"
      "application/x-zstd"
    ]));
  };
}
