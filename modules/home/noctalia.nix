{
  config,
  flake,
  inputs,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dafitt.noctalia;
  noctaliaExe = getExe config.programs.noctalia.package;
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
    nix.settings = {
      extra-substituters = [ "https://noctalia.cachix.org" ];
      extra-trusted-public-keys = [
        "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
      ];
    };

    home.packages = with pkgs; [
      ddcutil

      # plugin:nix-search
      nix-search-tv

      # plugin:screen-recorder
      gpu-screen-recorder

      # plugin:screen-toolkits
      bc
      curl
      ffmpeg
      gifski
      grim
      imagemagick
      jq
      slurp
      tesseract
      translate-shell
      wl-screenrec
      zbar
    ];

    programs.noctalia = {
      enable = true;
      systemd.enable = true;

      # https://docs.noctalia.dev/noctalia/
      #$ nix-converter -f .local/state/noctalia/settings.toml -l toml -unsafe-keys -sort-iterators hashmap
      settings = {
        bar = {
          main = {
            capsule_group = [
              {
                accordion = true;
                accordion_direction = "end";
                border_width = 1;
                enabled = true;
                fill = "surface_variant";
                foreground = "primary";
                id = "g1";
                members = [
                  "bar_4"
                  "bar_3"
                ];
                opacity = 0;
                padding = 6;
              }
              {
                accordion = true;
                accordion_direction = "start";
                border_width = 1;
                enabled = true;
                fill = "surface_variant";
                foreground = "primary";
                id = "g2";
                members = [
                  "cat"
                  "gamermode"
                ];
                opacity = 0;
                padding = 0;
              }
            ];
            center = [
              "clock"
              "notifications"
            ];
            end = [
              "group:g2"
              "tray"
              "brightness"
              "volume"
              "bluetooth"
              "network"
              "battery"
              "nix-monitor"
            ];
            margin_ends = 0;
            margin_opposite_edge = 2;
            position = "left";
            start = [
              "launcher"
              "workspaces"
              "media"
              "group:g1"
            ];
            widget_spacing = 12;
          };
          order = [
            "main"
            "utilities"
          ];
          utilities = {
            auto_hide = true;
            center = [
              "widget_3"
              "bar"
            ];
            enabled = true;
            end = [
              "radio"
              "bar_2"
            ];
            margin_ends = 300;
            position = "right";
            reserve_space = false;
            scale = 1.5000000149011612;
            show_on_workspace_switch = false;
            start = [
              "clipboard"
              "widget"
              "ocr"
              "widget_5"
              "recorder"
              "widget_2"
            ];
            thickness = 42;
          };
        };
        control_center = {
          calendar = {
            show_week_numbers = true;
          };
          shortcuts = [
            { type = "caffeine"; }
            { type = "dark_mode"; }
            { type = "nightlight"; }
            { type = "power_profile"; }
            { type = "session"; }
          ];
          show_shortcut_labels = false;
          sidebar = "full";
          sidebar_section = "none";
        };
        desktop_widgets = {
          grid = {
            cell_size = 64;
            major_interval = 4;
            visible = true;
          };
          schema_version = 2;
          widget = {
            desktop-widget-0000000000000001 = {
              box_height = 608;
              box_width = 608;
              cx = 1887.71484375;
              cy = 776.6875;
              # output = "DP-3";
              placement_height = 1440;
              placement_width = 2560;
              rotation = 0;
              settings = {
                background = false;
                circle = false;
                clock_style = "analog";
                color = "surface_variant";
                shadow = true;
              };
              type = "clock";
            };
            desktop-widget-0000000000000002 = {
              box_height = 65.453125;
              box_width = 335.05859375;
              cx = 1932.951171875;
              cy = 956.6015625;
              # output = "DP-3";
              placement_height = 1440;
              placement_width = 2560;
              rotation = 0;
              settings = {
                background = false;
                color = "on_surface_variant";
                format = "{:%Y-%M-%d}";
                shadow = false;
              };
              type = "clock";
            };
          };
          widget_order = [
            "desktop-widget-0000000000000001"
            "desktop-widget-0000000000000002"
          ];
        };
        dock = {
          background_opacity = 0;
          concave_edge_corners = false;
          enabled = true;
          icon_size = 32;
          launcher_custom_image_colorize = true;
          launcher_icon = "snowflake";
          launcher_position = "start";
          magnification_scale = 2;
          main_axis_padding = 100;
          position = "left";
          reserve_space = false;
          show_dots = true;
          smart_auto_hide = true;
        };
        nightlight = {
          enabled = true;
        };
        osd = {
          offset_y = 20;
          position = "bottom_center";
          position_vertical = "center_right";
        };
        plugin_settings = {
          "alexander/screen-toolkit" = {
            hide-cursor = false;
            panel_open_near_click = true;
            panel_placement = "attached";
            result_position = "center_right";
            video-path = "~/Videos/Recordings";
          };
        };
        plugins = {
          enabled = [
            "alexander/screen-toolkit"
            "avivbintangaringga/nix-monitor"
            "dotnetrob/cat"
            "dumbasaroc/bazaarsearch"
            "fel/ocr"
            "knyrps/nix-search"
            "nilsonlinux/world-radio"
            "noctalia/screen_recorder"
            "noctalia/timer"
            "noctalia/umbriel-companion"
            "noctalia/world_clock"
            "nomadcxx/gamer-mode"
            "oldirtty/color_picker"
            "prponkshe/umbriel-displays"
            "rylos/syncthing"
            "srounce/systemd"
            "thepunkoff/pomodoro"
            "yocraft/qrcode"
          ];
        };
        shell = {
          button_borders = false;
          font_family = "FiraCode Nerd Font";
          input_borders = false;
          launch_apps_as_systemd_services = true;
          launcher = {
            provider_prefix = "#";
            show_app_actions = true;
          };
          panel = {
            launcher_position = "top_left";
            open_near_click_control_center = true;
            open_near_click_session = true;
          };
          popup_borders = false;
          screen_corners = {
            enabled = true;
            size = 24;
          };
          screen_time_enabled = true;
          screenshot = {
            directory = "/home/david/Pictures/Screenshots";
          };
          session = {
            actions = [
              {
                action = "command";
                command = "systemctl hibernate";
                countdown_seconds = 0;
                enabled = true;
                glyph = "air-conditioning-disabled";
                label = "Hibernate";
                shortcut = "h";
                variant = "default";
              }
              {
                action = "lock";
                countdown_seconds = 0;
                enabled = true;
                shortcut = "l";
                variant = "default";
              }
              {
                action = "lock_and_suspend";
                countdown_seconds = 0;
                enabled = true;
                shortcut = "s";
                variant = "default";
              }
              {
                action = "logout";
                countdown_seconds = 0;
                enabled = true;
                shortcut = "o";
                variant = "outline";
              }
              {
                action = "reboot";
                countdown_seconds = 0;
                enabled = true;
                shortcut = "r";
                variant = "destructive";
              }
              {
                action = "shutdown";
                countdown_seconds = 0;
                enabled = true;
                shortcut = "p";
                variant = "destructive";
              }
            ];
          };
          settings_show_advanced = false;
          umbriel_overview_type_to_launch_enabled = true;
        };
        theme = {
          mode = "dark";
          source = "wallpaper";
          templates = {
            builtin_ids = [
              "umbriel"
            ];
          };
          wallpaper_scheme = "soft";
        };
        wallpaper = {
          default.path = "${config.xdg.userDirs.pictures}/Wallpapers/wallpaper.png";
          directory = "${config.xdg.userDirs.pictures}/Wallpapers";
        };
        widget = {
          bar = {
            type = "noctalia/timer:bar";
          };
          bar_2 = {
            type = "noctalia/world_clock:bar";
          };
          bar_3 = {
            type = "prponkshe/umbriel-displays:bar";
          };
          bar_4 = {
            type = "noctalia/umbriel-companion:bar";
          };
          cat = {
            type = "dotnetrob/cat:cat";
          };
          clipboard = {
            glyph = "clipboard-text-filled";
          };
          clock = {
            capsule_radius = "auto";
            tooltip_format = "%Y-%M-%d";
          };
          launcher = {
            glyph = "snowflake";
          };
          media = {
            hide_when_idle = true;
            hide_when_no_media = true;
          };
          network = {
            show_label = false;
          };
          nix-monitor = {
            actions = {
              right = "settings-open-plugin avivbintangaringga/nix-monitor";
            };
            show_text = false;
            type = "avivbintangaringga/nix-monitor:nix-monitor";
          };
          ocr = {
            type = "fel/ocr:ocr";
          };
          radio = {
            show_now_playing = false;
            type = "nilsonlinux/world-radio:radio";
          };
          recorder = {
            type = "noctalia/screen_recorder:recorder";
          };
          screenshot = {
            actions = {
              back = "screenshot-fullscreen";
            };
          };
          tray = {
            drawer = true;
            drawer_item_size = 24;
            scale = 1.2;
          };
          widget = {
            type = "oldirtty/color_picker:widget";
          };
          widget_2 = {
            type = "yocraft/qrcode:widget";
          };
          widget_3 = {
            type = "thepunkoff/pomodoro:widget";
          };
          widget_5 = {
            actions = {
              right = "settings-open-plugin alexander/screen-toolkit";
            };
            type = "alexander/screen-toolkit:widget";
          };
          workspaces = {
            label_source = "name";
            scale = 1.1500000000000001;
            style = "focus_hint";
          };
        };
      };
    };
    xdg.configFile = flake.lib.mkMutableFiles [ "noctalia/config.toml" ];

    home.file."${config.xdg.userDirs.pictures}/Wallpapers/wallpaper.png".source = config.stylix.image;

    services.hypridle.settings.general.lock_cmd = "${noctaliaExe} msg session lock";

    # [Keybinds](https://docs.noctalia.dev/getting-started/keybinds/)
    wayland.windowManager.hyprland.settings = {
      on = [
        {
          _args = [
            "hyprland.start"
            (mkLuaInline ''function() hl.dsp.exec_cmd("${pkgs.systemd}/bin/systemctl restart --user noctalia.service") end'')
          ];
        }
      ];
      bind = [
        {
          _args = [
            "SUPER + B"
            (mkLuaInline ''hl.dsp.exec_cmd("${noctaliaExe} msg bluetooth-toggle")'')
            { description = "Toggle Bluetooth"; }
          ];
        }
        {
          _args = [
            "SUPER + ALT + B"
            (mkLuaInline ''hl.dsp.exec_cmd("${noctaliaExe} msg panel-toggle control-center bluetooth")'')
            { description = "Toggle Bluetooth panel"; }
          ];
        }
        {
          _args = [
            "SUPER + L"
            (mkLuaInline ''hl.dsp.exec_cmd("${config.services.hypridle.settings.general.lock_cmd}")'')
            { description = "Lock screen"; }
          ];
        }
        {
          _args = [
            "SUPER + W"
            (mkLuaInline ''hl.dsp.exec_cmd("${noctaliaExe} msg bar-toggle main")'')
            { description = "Toggle bar"; }
          ];
        }
      ]
      ++ (optionals cfg.setAsDefaultLauncher [
        {
          _args = [
            "SUPER + Space"
            (mkLuaInline ''hl.dsp.exec_cmd("${noctaliaExe} msg panel-toggle launcher")'')
            { description = "Toggle launcher"; }
          ];
        }
      ]);
    };
    programs.niri.settings.binds = {
      "Mod+B".action.spawn-sh = "${noctaliaExe} msg bluetooth-toggle";
      "Mod+Alt+B".action.spawn-sh = "${noctaliaExe} msg panel-toggle control-center bluetooth";
      "Mod+L".action.spawn-sh = "${noctaliaExe} msg session lock";
      "Mod+W".action.spawn-sh = "${noctaliaExe} msg bar-toggle main";

      "Mod+Space" = mkIf cfg.setAsDefaultLauncher {
        action.spawn = [
          "${noctaliaExe}"
          "msg"
          "panel-toggle"
          "launcher"
        ];
      };
    };
    programs.umbriel = {
      settings.general.autostart = [ noctaliaExe ];
      settings.keybinds = {
        "Mod" = mkIf cfg.setAsDefaultLauncher {
          action = "spawn:${noctaliaExe} msg panel-toggle launcher";
          repeat = false;
        };
        "Mod+Space" = mkIf cfg.setAsDefaultLauncher {
          action = "spawn:${noctaliaExe} msg panel-toggle launcher";
          repeat = false;
        };
        "Mod+B" = {
          action = "spawn:${noctaliaExe} msg bluetooth-toggle";
          repeat = false;
        };
        "Mod+Alt+B" = {
          action = "spawn:${noctaliaExe} msg panel-toggle control-center bluetooth";
          repeat = false;
        };
        "Mod+L" = {
          action = "spawn:${noctaliaExe} msg session lock";
          repeat = false;
        };
        "Mod+W" = {
          action = "spawn:${noctaliaExe} msg bar-toggle main";
          repeat = false;
        };
      };
    };

    systemd.user.services.noctalia.Service.ExecCondition =
      ''${pkgs.systemd}/lib/systemd/systemd-xdg-autostart-condition "Hyprland:niri" ""'';
  };
}
