{ options, config, lib, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.desktops.hyprland.wlsunset;
in
{
  options.custom.desktops.hyprland.wlsunset = with types; {
    enable = mkBoolOpt config.custom.desktops.hyprland.enable "Enable the wlsunset, automatic adjustment for screen color temperature";
  };

  config = mkIf cfg.enable {
    services.wlsunset = {
      enable = true;

      latitude = "48.0";
      longitude = "12.6";

      temperature = {
        day = 6500; # neutral: 6500K
        night = 4000;
      };
    };
  };
}
