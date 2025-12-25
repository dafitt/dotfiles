{ pkgs, ... }:
{
  # https://syncthing.net/
  services.syncthing = {
    enable = true;
    guiAddress = "localhost:8384";
    overrideDevices = false;
    overrideFolders = false;
  };

  xdg.desktopEntries.syncthing = {
    name = "Syncthing";
    genericName = "Syncthing GUI";
    comment = "Open Syncthing GUI in a web browser";
    icon = "syncthing.svg";
    exec = "${pkgs.xdg-utils}/bin/xdg-open https://localhost:8384";
    terminal = false;
    type = "Application";
    categories = [
      "FileTransfer"
      "Monitor"
      "Settings"
      "System"
      "Utility"
      "X-WebApps"
    ];
  };

  wayland.windowManager.hyprland.settings = {
    bind = [ "SUPER_ALT, Z, exec, xdg-open https://localhost:8384" ];
  };
}
