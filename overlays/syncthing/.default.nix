{ channels, inputs, ... }:

final: prev: {
  syncthing =
    let
      desktopFile = prev.makeDesktopItem {
        name = "syncthing";
        desktopName = "Syncthing";
        genericName = "Syncthing Web App";
        comment = "Open Syncthing GUI in a web browser";
        exec = "${prev.xdg-utils}/bin/xdg-open https://localhost:8384";
        terminal = false;
        icon = "syncthing.svg";
        type = "Application";
        categories = [
          "FileTransfer"
          "Monitor"
          "Settings"
          "System"
          "Utility"
          "X-WebApps"
        ];
        mimeTypes = [
          "text/html"
          "text/xml"
          "application/xhtml_xml"
        ];
      };
    in
    prev.syncthing.overrideAttrs (oldAttrs: {
      postInstall = oldAttrs.postInstall + ''
        mkdir -p $out/share/applications
        ln -s ${desktopFile}/share/applications/* $out/share/applications
      '';
    });
}
