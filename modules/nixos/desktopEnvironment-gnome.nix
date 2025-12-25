{ pkgs, ... }:
{
  services.desktopManager.gnome.enable = true;
  services.udev.packages = [ pkgs.gnome-settings-daemon ];
}
