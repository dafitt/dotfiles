{ options, config, lib, pkgs, inputs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.features.desktops.hyprland;
in
{
  options.custom.features.desktops.hyprland = with types; {
    enable = mkBoolOpt false "Enable the Hyprland desktop environment";
  };

  config = mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;

      xwayland.enable = true;
    };

    environment.sessionVariables.NIXOS_OZONE_WL = "1";

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
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };

    security.pam.services.swaylock = { }; # [swaylock fix](https://github.com/NixOS/nixpkgs/issues/158025)
  };
}
