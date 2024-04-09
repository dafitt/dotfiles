{ options, config, lib, pkgs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.gaming.steam;
  osCfg = osConfig.dafitt.gaming.steam or null;
in
{
  options.dafitt.gaming.steam = with types; {
    enable = mkBoolOpt (osCfg.enable or config.dafitt.gaming.enableSuite) "Enable steam";
  };

  config = mkIf cfg.enable {
    services.flatpak.packages = [
      "com.valvesoftware.Steam"
      "org.freedesktop.Platform.VulkanLayer.gamescope"
      "com.valvesoftware.Steam.Utility.steamtinkerlaunch"
    ];

    wayland.windowManager.hyprland.settings.windowrulev2 = [
      "bordercolor rgb(1887d8), class:steam"
      "float, class:steam, title:(Friends List)|(Settings)"
    ];
  };
}
