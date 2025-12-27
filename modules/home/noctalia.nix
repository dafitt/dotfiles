{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib;
{
  imports = [ inputs.noctalia.homeModules.default ];

  # https://docs.noctalia.dev/
  programs.noctalia-shell = {
    enable = true;
    systemd.enable = true;

    # [Settings](https://docs.noctalia.dev/getting-started/nixos/#config-ref)
    #$ bat ~/.config/noctalia/gui-settings.json
    settings = {
      general = {
        animationDisabled = true;
      };
      bar = {
        density = "comfortable";
        widgets = {
          left = [
            {
              id = "CustomButton";
              icon = "rocket";
              leftClickExec = "noctalia-shell ipc call launcher toggle";
            }
            {
              id = "Workspace";
              colorizeIcons = true;
              hideUnoccupied = false;
              labelMode = "index";
              showApplications = true;
            }
            {
              id = "MediaMini";
            }
          ];
          center = [
            {
              id = "Tray";
              drawerEnabled = false;
            }
            {
              id = "Clock";
              formatHorizontal = "yyyy-MM-ddTHH:mm";
              formatVertical = "MM dd - HH mm";
              useMonospacedFont = true;
              usePrimaryColor = true;
            }
            {
              id = "NotificationHistory";
            }
          ];
          right = [
            {
              id = "SystemMonitor";
            }
            {
              id = "Battery";
              alwaysShowPercentage = false;
              warningThreshold = 30;
            }
            {
              id = "Brightness";
            }
            {
              id = "Volume";
            }
            {
              id = "Bluetooth";
            }
            {
              id = "WiFi";
            }
            {
              id = "ControlCenter";
              useDistroLogo = true;
            }
          ];
        };
      };
      wallpaper.enabled = false;
    };
  };

  # [Keybinds](https://docs.noctalia.dev/getting-started/keybinds/)
  wayland.windowManager.hyprland.settings.bind = [
    "SUPER, W, exec, ${getExe config.programs.noctalia-shell.package} ipc call bar toggle"
    "SUPER, L, exec, ${getExe config.programs.noctalia-shell.package} ipc call lockScreen lock"
  ];

  systemd.user.services.noctalia-shell.Service.ExecCondition =
    ''${pkgs.systemd}/lib/systemd/systemd-xdg-autostart-condition "Hyprland:niri" ""'';
}
