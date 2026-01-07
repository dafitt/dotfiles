{ lib, pkgs, ... }:

# [Must Have's](https://wiki.hypr.land/Useful-Utilities/Must-have/)
with lib;
{
  # Polkit implementation
  security.soteria.enable = true;

  # Userspace virtual filesystem
  services.gvfs = {
    enable = true;
    package = pkgs.gvfs;
  };

  # Auto-mounting
  services.udisks2 = {
    enable = true;
    settings = {
      "udisks2.conf".defaults = {
        allow = "exec";
      };
    };
  };

  # Xfce programs
  programs.xfconf.enable = true;

  services.power-profiles-daemon.enable = mkDefault true;

  services.accounts-daemon.enable = true;

  services.gnome = {
    evolution-data-server.enable = true;
    glib-networking.enable = true;
    gnome-keyring.enable = true;
    gnome-online-accounts.enable = true;
  };

  # Monitor backlight control
  programs.light.enable = true;
}
