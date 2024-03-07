{ config, lib, options, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.desktops.hyprland.gammastep;
in
{
  options.custom.desktops.hyprland.gammastep = with types; {
    enable = mkBoolOpt config.custom.desktops.hyprland.enable "Enable the gammastep, automatic adjustment for screen color temperature";
  };

  config = mkIf cfg.enable {
    services.gammastep = {
      enable = true;

      provider = "manual";
      latitude = 48.00;
      longitude = 12.65;

      temperature = {
        day = 6500; # neutral: 6500K
        night = 5900;
      };
      settings = {
        general = {
          adjustment-method = "wayland";

          fade = "1"; # gradually apply the new screen temperature/brightness over a couple of seconds.
          # it is a fake brightness adjustment obtained by manipulating the gamma ramps,
          # which means that it does not reduce the backlight　of the screen.
          # Preferably only use it if your normal backlight adjustment is too coarse-grained.
          #brightness-day = "1.0";
          #brightness-night = "0.8";
        };
      };
    };
  };
}
