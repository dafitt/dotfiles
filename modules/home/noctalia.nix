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
  imports = with inputs; [
    noctalia.homeModules.default
    self.homeModules.stylix
  ];

  options.dafitt.noctalia = {
    setAsDefaultLauncher = mkEnableOption "making it the default launcher";
  };

  config = {
    home.packages = with pkgs; [
      gpu-screen-recorder
    ];

    # https://docs.noctalia.dev/
    programs.noctalia-shell = {
      enable = true;
      systemd.enable = true;

      # https://docs.noctalia.dev/getting-started/nixos/#config-ref
      #$ cat ~/.config/noctalia/gui-settings.json | nix-converter
      settings = {
        general = {
          animationDisabled = true;
        };
        appLauncher = {
          customLaunchPrefix = "uwsm app --";
          customLaunchPrefixEnabled = true;
          viewMode = "grid";
        };
        audio = {
          cavaFrameRate = 144;
          visualizerType = "mirrored";
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
                formatVertical = "yy MM dd T HH :mm";
                tooltipFormat = "yyyy-MM-ddTHH:mm";
                useMonospacedFont = true;
                usePrimaryColor = true;
              }
              {
                id = "NotificationHistory";
              }
              {
                id = "plugin:timer";
              }
            ];
            right = [
              {
                id = "plugin:pomodoro";
              }
              {
                id = "plugin:catwalk";
              }
              {
                id = "SystemMonitor";
              }
              {
                id = "Battery";
                alwaysShowPercentage = false;
                showPowerProfiles = true;
                warningThreshold = 30;
              }
              {
                id = "Brightness";
                displayMode = "alwaysHide";
              }
              {
                id = "Volume";
                displayMode = "alwaysHide";
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
        controlCenter = {
          shortcuts = {
            left = [
              { id = "WallpaperSelector"; }
              { id = "plugin:screen-recorder"; }
            ];
            right = [
              { id = "KeepAwake"; }
              { id = "NightLight"; }
              { id = "DarkMode"; }
              { id = "PowerProfile"; }
            ];
          };
        };
        location = {
          name = "Palling";
        };
        osd = {
          enabledTypes = [
            0
            1
            2
            3
            4
          ];
        };
        wallpaper = {
          randomEnabled = true;
          randomIntervalSec = 86400;
        };
      };

      # https://docs.noctalia.dev/getting-started/nixos/#plugins
      #$ cat ~/.config/noctalia/plugins/<name>/settings.json | nix-converter
      plugins = {
        sources = [
          {
            enabled = true;
            name = "Official Noctalia Plugins";
            url = "https://github.com/noctalia-dev/noctalia-plugins";
          }
        ];
        states = {
          catwalk = {
            enabled = true;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
          kaomoji-provider = {
            enabled = true;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
          keybind-cheatsheet = {
            enabled = true;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
          pomodoro = {
            enabled = true;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
          screen-recorder = {
            enabled = true;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
          screenshot = {
            enabled = true;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
          timer = {
            enabled = true;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
          unicode-picker = {
            enabled = true;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
        };
        version = 1;
      };

      #$ cat ~/.config/noctalia/plugins/<name>/settings.json | nix-converter
      pluginSettings = {
        pomodoro = {
          compactMode = true;
        };
      };
    };

    home.file."${config.xdg.userDirs.pictures}/Wallpapers/wallpaper.png".source = config.stylix.image;

    # [Keybinds](https://docs.noctalia.dev/getting-started/keybinds/)
    wayland.windowManager.hyprland.settings.bind = [
      "Super, W, exec, ${getExe config.programs.noctalia-shell.package} ipc call bar toggle"
      "Super, L, exec, ${getExe config.programs.noctalia-shell.package} ipc call lockScreen lock"
    ]
    ++ (optionals cfg.setAsDefaultLauncher [
      "Super, SPACE, exec, ${getExe config.programs.noctalia-shell.package} ipc call launcher toggle"
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
