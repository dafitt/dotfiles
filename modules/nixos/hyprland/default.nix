{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.hyprland;
in
{
  options.dafitt.hyprland = with types; {
    enable = mkEnableOption "the Hyprland desktop environment";
  };

  config = mkIf cfg.enable {
    programs.hyprland = {
      enable = true;

      # https://wiki.hypr.land/Useful-Utilities/Systemd-start/
      withUWSM = true;
    };

    # used by plugins
    nix.settings = {
      substituters = [
        "https://hyprland.cachix.org"
        "https://hyprland-community.cachix.org"
      ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "hyprland-community.cachix.org-1:5dTHY+TjAJjnQs23X+vwMQG4va7j+zmvkTKoYuSXnmE="
      ];
    };

    # [Must Have's](https://wiki.hypr.land/Useful-Utilities/Must-have/)
    programs.light.enable = true; # Monitor backlight control
    services = {
      gvfs = {
        enable = true; # userspace virtual filesystem (to be able to browse remote resources)
        package = pkgs.gvfs;
      };
      devmon.enable = true;
      udisks2 = {
        enable = true; # to allow applications to query and manipulate storage devices
        settings = {
          "udisks2.conf".defaults = {
            allow = "exec";
          };
        };
      };
      power-profiles-daemon.enable = lib.mkDefault true;
      accounts-daemon.enable = true;
      gnome = {
        evolution-data-server.enable = true;
        glib-networking.enable = true;
        gnome-keyring.enable = true;
        gnome-online-accounts.enable = true;
      };
    };

    security.polkit.enable = true;
  };
}
