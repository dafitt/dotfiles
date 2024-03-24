{ options, config, lib, pkgs, osConfig ? { }, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.gaming.steam;
  osCfg = osConfig.custom.gaming.steam or null;
in
{
  options.custom.gaming.steam = with types; {
    enable = mkBoolOpt (osCfg.enable or config.custom.gaming.enableSuite) "Enable steam";
  };

  config = mkIf cfg.enable {
    services.flatpak.packages = [
      "com.valvesoftware.Steam"
    ];

    wayland.windowManager.hyprland.settings.windowrulev2 = [
      "bordercolor rgb(1887d8), class:steam"
      "float, class:steam, title:(Friends List)|(Settings)"
    ];
  };
}
