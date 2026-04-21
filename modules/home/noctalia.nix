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
  #meta.doc = builtins.toFile "doc.md" ''
  #  Installs and configures Noctalia shell.
  #  <https://docs.noctalia.dev/>
  #'';

  imports = with inputs; [
    # noctalia.homeModules.default
    self.homeModules.stylix
  ];

  options.dafitt.noctalia = {
    setAsDefaultLauncher = mkEnableOption "making it the default launcher";
  };

  config = {
    home.packages = with pkgs; [
      # plugin:screen-recorder
      gpu-screen-recorder

      # plugin:screen-toolkit
      grim
      slurp
      tesseract
      imagemagick
      zbar
      curl
      translate-shell
      wl-screenrec
      ffmpeg
      gifski
      jq

      # plugin:file-search
      fd
    ];

    programs.noctalia-shell = {
      enable = true;
      systemd.enable = true;

      # https://docs.noctalia.dev/getting-started/nixos/#config-ref
      #$ noctalia-shell ipc call state all | jq .settings | nix-converter
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
            ];
            center = [
              {
                id = "plugin:screen-toolkit";
              }
              {
                id = "MediaMini";
              }
              {
                id = "Tray";
                drawerEnabled = false;
                blacklist = [
                  "nm-applet"
                  "udiskie"
                ];
              }
              {
                id = "plugin:syncthing-status";
              }
              {
                id = "plugin:usb-drive-manager";
              }
              {
                id = "NotificationHistory";
              }
              {
                id = "Clock";
                clockColor = "primary";
                customFont = config.stylix.fonts.monospace.name;
                formatHorizontal = "yyyy-MM-dd HH:mm";
                formatVertical = "yy MM dd - HH :mm";
                tooltipFormat = "yyyy-MM-ddTHH:mm";
                useCustomFont = true;
                usePrimaryColor = true;
              }
              {
                id = "plugin:timer";
              }
              {
                id = "plugin:pomodoro";
              }
            ];
            right = [
              {
                id = "plugin:catwalk";
              }
              {
                id = "Battery";
                displayMode = "alwaysShow";
                showPowerProfiles = true;
                warningThreshold = 30;
              }
              {
                id = "KeepAwake";
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
        notifications = {
          location = "top";
        };
        osd = {
          enabledTypes = [
            0
            1
            2
            3
            4
          ];
          location = "bottom";
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
          catwalk.enabled = true;
          file-search.enabled = true;
          kaomoji-provider.enabled = true;
          keybind-cheatsheet.enabled = true;
          pomodoro.enabled = true;
          screen-recorder.enabled = true;
          screen-toolkit.enabled = true;
          screenshot.enabled = true;
          syncthing-status.enabled = true;
          timer.enabled = true;
          translator.enabled = true;
          unicode-picker.enabled = true;
          usb-drive-manager.enabled = true;
          zed-provider.enabled = true;
        };
        version = 2;
      };

      #$ cat ~/.config/noctalia/plugins/<name>/settings.json | nix-converter
      pluginSettings = {
        pomodoro = {
          compactMode = true;
        };
      };
    };

    home.file."${config.xdg.userDirs.pictures}/Wallpapers/wallpaper.png".source = config.stylix.image;

    services.hypridle.settings.general.lock_cmd =
      "${getExe config.programs.noctalia-shell.package} ipc call lockScreen lock";

    # [Keybinds](https://docs.noctalia.dev/getting-started/keybinds/)
    wayland.windowManager.hyprland.settings = {
      exec = [
        "${pkgs.systemd}/bin/systemctl restart --user noctalia-shell.service"
      ];
      bind = [
        "Super, W, exec, ${getExe config.programs.noctalia-shell.package} ipc call bar toggle"
        "Super, L, exec, ${config.services.hypridle.settings.general.lock_cmd}"
      ]
      ++ (optionals cfg.setAsDefaultLauncher [
        "Super, SPACE, exec, ${getExe config.programs.noctalia-shell.package} ipc call launcher toggle"
      ]);
    };
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
