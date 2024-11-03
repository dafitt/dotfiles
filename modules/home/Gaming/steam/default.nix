{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.Gaming.steam;
in
{
  options.dafitt.Gaming.steam = with types; {
    enable = mkBoolOpt config.dafitt.Gaming.enableSuite "Enable steam.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      ludusavi # Savegame manager
    ];

    # [Using Steam in a Flatpak](https://steamcommunity.com/sharedfiles/filedetails/?id=2615011323)
    # [Steam-NixOS](https://github.com/Jovian-Experiments/Jovian-NixOS)
    services.flatpak = {
      packages = [
        "com.valvesoftware.Steam"
        "com.valvesoftware.SteamLink"
        "com.valvesoftware.Steam.CompatibilityTool.Proton-GE"
        "com.valvesoftware.Steam.Utility.protontricks"
        "com.valvesoftware.Steam.Utility.steamtinkerlaunch"
        "org.freedesktop.Platform.VulkanLayer.gamescope//23.08"
        "org.freedesktop.Platform.VulkanLayer.MangoHud//23.08" # toggle HUD with Shift_R+F12
        "org.freedesktop.Platform.VulkanLayer.vkBasalt//23.08"
      ];
      overrides = {
        "com.valvesoftware.Steam".Environment = {
          #ENABLE_VKBASALT = "1";
          #MANGOHUD = "1";
        };
      };
    };

    wayland.windowManager.hyprland.settings.windowrulev2 = [
      "bordercolor rgb(1887d8), class:steam"
      "float, class:steam, title:(Friends List)|(Settings)"
    ];
  };
}
