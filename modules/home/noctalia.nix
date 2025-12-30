{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib;
let
  cfg = config.dafitt.noctalia;
in
{
  imports = [ inputs.noctalia.homeModules.default ];

  options.dafitt.noctalia = {
    setAsDefaultLauncher = mkEnableOption "making it the default launcher";
  };

  config = {
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
          position = "left";
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
                labelMode = "name";
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
        appLauncher = {
          customLaunchPrefix = "uwsm app --";
          customLaunchPrefixEnabled = true;
          viewMode = "grid";
        };
        wallpaper.enabled = false;
      };
    };

    # [Keybinds](https://docs.noctalia.dev/getting-started/keybinds/)
    wayland.windowManager.hyprland.settings.bind = [
      "SUPER, W, exec, ${getExe config.programs.noctalia-shell.package} ipc call bar toggle"
      "SUPER, L, exec, ${getExe config.programs.noctalia-shell.package} ipc call lockScreen lock"
    ]
    ++ (optionals cfg.setAsDefaultLauncher [
      "SUPER, SPACE, exec, ${getExe config.programs.noctalia-shell.package} ipc call launcher toggle"
    ]);
    programs.niri.settings.binds = {
      "Mod+W".action.spawn-sh = "${getExe config.programs.noctalia-shell.package} ipc call bar toggle";
      "Mod+L".action.spawn-sh =
        "${getExe config.programs.noctalia-shell.package} ipc call lockScreen lock";

      "Mod+Space" = mkIf cfg.setAsDefaultLauncher {
        action.spawn = [
          "${getExe config.programs.noctalia-shell.package}"
          "ipc"
          "call"
          "launcher"
          "toggle"
        ];
      };
    };

    systemd.user.services.noctalia-shell.Service.ExecCondition =
      ''${pkgs.systemd}/lib/systemd/systemd-xdg-autostart-condition "Hyprland:niri" ""'';
  };
}
