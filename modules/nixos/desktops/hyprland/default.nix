{ options, config, lib, pkgs, inputs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.desktops.hyprland;
in
{
  options.dafitt.desktops.hyprland = with types; {
    enable = mkBoolOpt true "Enable the Hyprland desktop environment";
  };

  config = mkIf cfg.enable {
    programs.hyprland.enable = true;

    nix.settings = {
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };

    # [Must Have's](https://wiki.hyprland.org/Useful-Utilities/Must-have/)
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

    systemd.user.services."polkit-gnome-authentication-agent-1" = {
      description = "polkit-gnome-authentication-agent-1";
      wants = [ "hyprland-session.target" ];
      after = [ "hyprland-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
      wantedBy = [ "hyprland-session.target" ];
    };

    dafitt.displayManager.greetd.sessionPaths = [ "${config.programs.hyprland.package}/share/wayland-sessions" ];
  };
}
