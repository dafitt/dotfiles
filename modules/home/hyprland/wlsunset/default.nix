{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.hyprland.wlsunset;
in
{
  options.dafitt.hyprland.wlsunset = with types; {
    enable = mkEnableOption "wlsunset, automatic adjustment of screen color temperature for hyprland";
  };

  config = mkIf cfg.enable {
    services.wlsunset = {
      enable = true;

      latitude = "48.0";
      longitude = "12.6";

      temperature = {
        day = 6500; # neutral: 6500K
        night = 4200;
      };
    };
  };
}
