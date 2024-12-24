{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.hyprland.wlsunset;
in
{
  options.dafitt.hyprland.wlsunset = with types; {
    enable = mkBoolOpt false "Whether to enable the wlsunset, automatic adjustment for screen color temperature.";
  };

  config = mkIf cfg.enable {
    services.wlsunset = {
      enable = true;
      systemdTarget = "hyprland-session.target";

      latitude = "48.0";
      longitude = "12.6";

      temperature = {
        day = 6500; # neutral: 6500K
        night = 4200;
      };
    };
  };
}
