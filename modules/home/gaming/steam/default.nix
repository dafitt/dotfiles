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
    # [Using Steam in a Flatpak](https://steamcommunity.com/sharedfiles/filedetails/?id=2615011323)
    # [Steam-NixOS](https://github.com/Jovian-Experiments/Jovian-NixOS)

    services.flatpak = {
      packages = [
        "com.valvesoftware.Steam"
        "com.valvesoftware.SteamLink"
        "com.valvesoftware.Steam.CompatibilityTool.Boxtron"
        "com.valvesoftware.Steam.CompatibilityTool.Proton-GE"
        "com.valvesoftware.Steam.Utility.protontricks"
        "com.valvesoftware.Steam.Utility.steamtinkerlaunch"
        "org.freedesktop.Platform.VulkanLayer.gamescope//23.08"
        "org.freedesktop.Platform.VulkanLayer.MangoHud//23.08"
        "org.freedesktop.Platform.VulkanLayer.vkBasalt//23.08"
      ];
      overrides = {
        "com.valvesoftware.Steam".Environment = {
          ENABLE_VKBASALT = "1";
          MANGOHUD = "1";
        };
      };
    };

    wayland.windowManager.hyprland.settings.windowrulev2 = [
      "bordercolor rgb(1887d8), class:steam"
      "float, class:steam, title:(Friends List)|(Settings)"
    ];
  };
}
