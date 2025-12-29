{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ludusavi # Savegame manager
  ];

  # [Using Steam in a Flatpak](https://steamcommunity.com/sharedfiles/filedetails/?id=2615011323)
  # [Steam-NixOS](https://github.com/Jovian-Experiments/Jovian-NixOS)
  services.flatpak = {
    packages = [
      "com.valvesoftware.Steam"
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

  wayland.windowManager.hyprland.settings.windowrule = [
    "bordercolor rgb(1887d8), class:steam"
    "float, class:steam, title:(Friends List)|(Settings)"
  ];
  programs.niri.settings = {
    window-rules = [
      {
        matches = [
          {
            app-id = "steam";
            title = "(Friends List)|(Settings)";
          }
        ];
        open-floating = true;
      }
    ];
  };
}
