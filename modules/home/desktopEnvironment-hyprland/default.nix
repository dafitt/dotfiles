{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dafitt.desktopEnvironment-hyprland;
in
{
  imports = with inputs; [
    self.homeModules.noctalia
    self.homeModules.pyprland
    self.homeModules.stylix
    ../desktopEnvironment-common/keybinds.nix
    ../desktopEnvironment-common/mustHaves.nix
    ./animated-background.nix
    ./hypridle.nix
    ./monitors.nix
    ./nwg-displays.nix
    ./plugins.nix
  ];

  options.dafitt.desktopEnvironment-hyprland = with types; {
    smartGaps = mkEnableOption "smart gaps workspace rules (no gaps when only one window on workspace)";

    ttyAutostart = mkOption {
      type = bool;
      default = true;
      description = "Whether to autostart Hyprland from a tty after login.";
    };
    ttyAutostartNumbers = mkOption {
      type = str;
      default = "2";
      description = "TTY numbers on where to autostart from after login. Bash strings [] syntax.";
    };
  };

  config = mkMerge [
    {
      dafitt = {
        desktopEnvironment-hyprland = {
          hypridle.enable = true;
          plugins.hyprexpo.enable = true;
        };
        pyprland.enable = true;
      };

      home.packages = with pkgs; [
        grimblast
        hyprkeys
        hyprpicker
        hyprshot
        hyprsysteminfo
        waypaper
      ];

      # [Hyprland](https://github.com/hyprwm/Hyprland)
      wayland.windowManager.hyprland = {
        enable = true;
        systemd.enable = false; # conflicts with UWSM

        settings = {
          # [Variables](https://wiki.hypr.land/Configuring/Variables/)

          xwayland.force_zero_scaling = true;

          general = {
            # https://wiki.hypr.land/Configuring/Variables/#general
            gaps_in = 5;
            gaps_out = 8;
            border_size = 2;
            resize_on_border = true;
            layout = "dwindle";
            "col.active_border" = mkForce "rgb(${config.lib.stylix.colors.base0B})";
          };
          dwindle = {
            # https://wiki.hypr.land/Configuring/Dwindle-Layout/
            pseudotile = true; # master switch for pseudotiling
            force_split = 2;
            preserve_split = true; # you probably want this
            default_split_ratio = 1.25; # 0.1 - 1.9
          };
          misc = {
            # https://wiki.hypr.land/Configuring/Variables/#misc
            disable_autoreload = true;
            disable_hyprland_logo = true;
            focus_on_activate = true;
            key_press_enables_dpms = true;
            animate_manual_resizes = true;
            animate_mouse_windowdragging = true;
            background_color = mkForce "rgb(${config.lib.stylix.colors.base01})";
          };
          decoration = {
            # https://wiki.hypr.land/Configuring/Variables/#decoration
            #active_opacity = 0.97;
            #inactive_opacity = 0.97;

            rounding = 16;

            dim_inactive = true;
            dim_strength = 0.1;

            shadow = {
              range = 16;
              render_power = 2;
              color = mkForce "rgba(${config.lib.stylix.colors.base01}E5)";
              color_inactive = "rgba(00000000)";
            };

            blur = {
              xray = true;
            };
          };
          animations = {
            # https://wiki.hypr.land/Configuring/Animations/
            enabled = true;

            bezier = [
              # Used in animation `CURVE`
              # "NAME,X0,Y0,X1,Y1"
              # https://www.cssportal.com/css-cubic-bezier-generator/
              "ease,0.25,0.1,0.25,1"
              "easeIn,0.42,0,1,1"
              "easeInOut,0.58,0.28,0.52,0.95"
              "easeInOutBack,0.68,-0.55,0.265,10.55"
              "easeInOutQuart,0.77,0,0.175,1"
              "easeOut,0,0,0.58,1"
              "easeOutBack,0.175,0.885,0.32,10.275"
              "easeOutCirc,0.075,0.82,0.165,1"
              "easeOutCubic,0.215,0.61,0.355,1"
              "easeOutExpo,0.19,1,0.22,1"
              "easeOutQuad,0.25,0.46,0.45,0.94"
              "easeOutQuart,0.165,0.84,0.44,1"
              "easeOutQuint,0.23,1,0.32,1"
              "easeOutSine,0.39,0.575,0.565,1"
              "linear,0,0,1,1"
            ];
            animation = [
              # "NAME,ONOFF,SPEED,CURVE,STYLE"
              "global,      1, 5,   easeOutExpo"
              "windows,     1, 5,   easeOutExpo, popin"
              "layers,      1, 5,   easeOutExpo, slide"
              "workspaces,  1, 7.5, easeOutExpo, slidefadevert 5%"
            ];
          };

          windowrule = [
            # https://wiki.hypr.land/Configuring/Window-Rules/
            # https://regex101.com/
            #$ hyprctl clients
            "match:title (.)+, match:xwayland 0, match:float 1, opacity 1 0.7" # make inactive floating windows (with titles) more transparent
            "match:xwayland 1, border_color rgb(${config.lib.stylix.colors.base09})" # other border color for xwayland windows

            "match:title (A|a)lert, float on"
            "match:title (S|s)etup, float on"
            "match:title (P|p)rogress, float on"

            "match:title .*, no_blur on" # Disables blur for windows. Substantially improves performance.
          ];
          layerrule = [
            "match:namespace .*, xray 1"
            "match:namespace launcher, blur on"
            "match:namespace launcher, ignore_alpha 0.5"
          ];
          workspace = [ ];

          input = {
            # https://wiki.hypr.land/Configuring/Variables/#input
            # list of options `/usr/share/X11/xkb/rules/base.lst`
            kb_layout = "de";
            kb_variant = "nodeadkeys";
            numlock_by_default = true;
            follow_mouse = 1;
            accel_profile = mkDefault "adaptive";

            touchpad = {
              #clickfinger_behavior = true;
              drag_lock = true;
              tap-and-drag = true;
            };
          };
          cursor = {
            warp_on_change_workspace = 1;
            zoom_rigid = true;
            persistent_warps = true;
          };

          gestures = {
            # https://wiki.hypr.land/Configuring/Variables/#gestures
            workspace_swipe_forever = true;
          };

          gesture = [
            # https://wiki.hypr.land/Configuring/Gestures/
            "3, vertical, workspace"
          ];

          binds = {
            # https://wiki.hypr.land/Configuring/Variables/#binds
            workspace_back_and_forth = true;
            allow_workspace_cycles = true;
            scroll_event_delay = 150;
          };

          bind =
            with pkgs;
            [
              # https://wiki.hypr.land/Configuring/Binds/
              # https://wiki.hypr.land/Configuring/Dispatchers/

              "Super&Control, Q, exec, hyprctl dispatch exit" # Exit Hyprland all together
              "Super&Control, R, exec, hyprctl reload; forcerendererreload"
              "Super, Odiaeresis, exec, sleep 0.5 && hyprctl dispatch dpms off" # screen off

              # Window control
              "Super, Delete, exec, hyprctl kill" # kill a window by clicking it
              "Super, X, killactive," # close the active window
              "Super&Shift, X, forcekillactive," # kill the active window
              "Super, P, pseudo," # dwindle
              "Super, R, togglesplit," # dwindle
              "Super, H, swapnext,"
              "Super&Shift, H, swapnext, prev"
              "Super, F, fullscreenstate, 2 0"
              ", F11, fullscreen,"
              "Super, A, fullscreen, 1" # maximize only
              "Super, V, togglefloating," # Allow a window to float
              "Super, Z, alterzorder, top" # floating only
              "Super&Shift, Z, alterzorder, bottom" # floating only
              "Super, B, pin," # floating only
              "Super, Left, movefocus, l"
              "Super, Right, movefocus, r"
              "Super, Up, movefocus, u"
              "Super, Down, movefocus, d"
              "Super, Tab, cyclenext,"
              "Super&Shift, Left, swapwindow, l"
              "Super&Shift, Right, swapwindow, r"
              "Super&Shift, Up, swapwindow, u"
              "Super&Shift, Down, swapwindow, d"
              "Super&Shift, Tab, swapnext,"
              "Super&Alt, Plus, resizeactive, 100 0"
              "Super&Alt, Minus, resizeactive, -100 0"
              "Super&Alt, Right, resizeactive, 100 0"
              "Super&Alt, Left, resizeactive, -100 0"
              "Super&Alt, Down, resizeactive, 0 100"
              "Super&Alt, Up, resizeactive, 0 -100"
              # Window groups
              "Super&Control, G, togglegroup,"
              "Super, G, changegroupactive, f"
              "Super&Shift, G, changegroupactive, f"
              "Super&Shift&Control, Left, movewindoworgroup, l"
              "Super&Shift&Control, Right, movewindoworgroup, r"
              "Super&Shift&Control, Up, movewindoworgroup, u"
              "Super&Shift&Control, Down, movewindoworgroup, d"
            ]
            ++
              optionals
                (
                  !any (config: config.enable) [
                    cfg.plugins.hyprsplit
                    cfg.plugins.hyprnome
                  ]
                )
                [
                  # Workspace control
                  "Super, 1, focusworkspaceoncurrentmonitor, 1"
                  "Super, 2, focusworkspaceoncurrentmonitor, 2"
                  "Super, 3, focusworkspaceoncurrentmonitor, 3"
                  "Super, 4, focusworkspaceoncurrentmonitor, 4"
                  "Super, 5, focusworkspaceoncurrentmonitor, 5"
                  "Super, 6, focusworkspaceoncurrentmonitor, 6"
                  "Super, 7, focusworkspaceoncurrentmonitor, 7"
                  "Super, 8, focusworkspaceoncurrentmonitor, 8"
                  "Super, 9, focusworkspaceoncurrentmonitor, 9"
                  "Super, 0, focusworkspaceoncurrentmonitor, 10"
                  "Super, D, focusworkspaceoncurrentmonitor, name:D" # desktop only
                  "Super, code:87, focusworkspaceoncurrentmonitor, 1" # Numpad
                  "Super, code:88, focusworkspaceoncurrentmonitor, 2" # Numpad
                  "Super, code:89, focusworkspaceoncurrentmonitor, 3" # Numpad
                  "Super, code:83, focusworkspaceoncurrentmonitor, 4" # Numpad
                  "Super, code:84, focusworkspaceoncurrentmonitor, 5" # Numpad
                  "Super, code:85, focusworkspaceoncurrentmonitor, 6" # Numpad
                  "Super, code:79, focusworkspaceoncurrentmonitor, 7" # Numpad
                  "Super, code:80, focusworkspaceoncurrentmonitor, 8" # Numpad
                  "Super, code:81, focusworkspaceoncurrentmonitor, 9" # Numpad
                  "Super, code:91, focusworkspaceoncurrentmonitor, 10" # Numpad
                  "Super, code:86, focusworkspaceoncurrentmonitor, +1" # Numpad +
                  "Super, code:82, focusworkspaceoncurrentmonitor, -1" # Numpad -
                  "Super, backspace, focusworkspaceoncurrentmonitor, previous"
                  "Super, mouse_DOWN, focusworkspaceoncurrentmonitor, -1"
                  "Super, mouse_UP, focusworkspaceoncurrentmonitor, +1"

                  # Move active window to a workspace
                  "Super&Shift, 1, movetoworkspacesilent, 1"
                  "Super&Shift, 2, movetoworkspacesilent, 2"
                  "Super&Shift, 3, movetoworkspacesilent, 3"
                  "Super&Shift, 4, movetoworkspacesilent, 4"
                  "Super&Shift, 5, movetoworkspacesilent, 5"
                  "Super&Shift, 6, movetoworkspacesilent, 6"
                  "Super&Shift, 7, movetoworkspacesilent, 7"
                  "Super&Shift, 8, movetoworkspacesilent, 8"
                  "Super&Shift, 9, movetoworkspacesilent, 9"
                  "Super&Shift, 0, movetoworkspacesilent, 10"
                  "Super&Shift, code:87, movetoworkspacesilent, 1" # Numpad
                  "Super&Shift, code:88, movetoworkspacesilent, 2" # Numpad
                  "Super&Shift, code:89, movetoworkspacesilent, 3" # Numpad
                  "Super&Shift, code:83, movetoworkspacesilent, 4" # Numpad
                  "Super&Shift, code:84, movetoworkspacesilent, 5" # Numpad
                  "Super&Shift, code:85, movetoworkspacesilent, 6" # Numpad
                  "Super&Shift, code:79, movetoworkspacesilent, 7" # Numpad
                  "Super&Shift, code:80, movetoworkspacesilent, 8" # Numpad
                  "Super&Shift, code:81, movetoworkspacesilent, 9" # Numpad
                  "Super&Shift, code:91, movetoworkspacesilent, 10" # Numpad
                  "Super&Shift, code:86, movetoworkspacesilent, +1" # Numpad +
                  "Super&Shift, code:82, movetoworkspacesilent, -1" # Numpad -
                ]
            ++ optionals (!cfg.plugins.hyprsplit.enable) [
              # Monitor control
              "Super&Control, Left, movecurrentworkspacetomonitor, l"
              "Super&Control, Right, movecurrentworkspacetomonitor, r"
              "Super&Control, Up, movecurrentworkspacetomonitor, u"
              "Super&Control, Down, movecurrentworkspacetomonitor, d"
            ]
            ++ [
              # some small helper programs
              "Super&Alt, U, exec, uwsm app -- ${gnome-characters}/bin/gnome-characters"
              "Super&Alt, K, exec, uwsm app -- ${getExe hyprpicker} | ${wl-clipboard-rs}/bin/wl-copy"
              "Super&Alt, SPACE, exec, uwsm app -- ${getExe nwg-drawer} -ovl"

              # Screenshots
              # quick fullscreen | copy save
              ", PRINT, exec, GRIMBLAST_HIDE_CURSOR=1 uwsm app -- ${getExe grimblast} copysave output ${config.xdg.userDirs.pictures}/Screenshots/$(date +'%F-%T_%N.png')"
              # select area | copy save
              "Super, PRINT, exec, GRIMBLAST_HIDE_CURSOR=1 uwsm app -- ${getExe grimblast} --notify --freeze copysave area ${config.xdg.userDirs.pictures}/Screenshots/$(date +'%F-%T_%N.png')"
              # quick fullscreen | edit | save
              "ALT, PRINT, exec, GRIMBLAST_HIDE_CURSOR=1 uwsm app -- ${getExe grimblast} --notify --freeze --cursor save output - | ${getExe satty} --filename - --fullscreen --output-filename ${config.xdg.userDirs.pictures}/Screenshots/$(date +'%F-%T_%N.png')"
              # select area | edit | save
              "Super&Alt, PRINT, exec, GRIMBLAST_HIDE_CURSOR=1 uwsm app -- ${getExe grimblast} --freeze save area - | ${getExe satty} --filename - --output-filename ${config.xdg.userDirs.pictures}/Screenshots/$(date +'%F-%T_%N.png')"
              # select area | ocr | copy
              "Super, T, exec, GRIMBLAST_HIDE_CURSOR=1 uwsm app -- ${getExe grimblast} --freeze save area - | ${getExe tesseract} - - -l deu+eng | ${wl-clipboard-rs}/bin/wl-copy"
              # GRIMBLAST_HIDE_CURSOR=1: https://github.com/Jas-SinghFSU/HyprPanel/issues/832
            ];

          # Bind: mouse binds
          bindm = [
            # Move/resize windows with mainMod + LMB/RMB and dragging
            "Super, mouse:272, movewindow"
            "Super, mouse:273, resizewindow"
          ];

          monitor = [ ", preferred, auto, 1" ];

          exec-shutdown = [
            ''hyprctl --batch $(hyprctl -j clients | ${getExe pkgs.jq} -j '.[] | "dispatch closewindow address:\(.address); "')'' # close all windows
            "uwsm stop"
          ];
        }
        // optionalAttrs cfg.smartGaps {
          workspace = [
            "w[tv1], gapsout:0, gapsin:0"
            "f[1], gapsout:0, gapsin:0"
          ];
          windowrule = [
            "match:float 0, match:workspace w[tv1], bordersize 0"
            "match:float 0, match:workspace w[tv1], rounding 0"
            "match:float 0, match:workspace f[1], bordersize 0"
            "match:float 0, match:workspace f[1], rounding 0"
          ];
        };
      };

      services.hyprpolkitagent.enable = true;
      systemd.user.services.hyprpolkitagent.Service.ExecCondition =
        ''${pkgs.systemd}/lib/systemd/systemd-xdg-autostart-condition "Hyprland" ""'';

      # https://wiki.hypr.land/Configuring/Environment-variables/
      #` export KEY=VAL
      xdg.configFile."uwsm/env-hyprland".text =
        let
          hyprlandEnvList = config.wayland.windowManager.hyprland.settings.env or [ ];
          modifiedHyprlandEnvVars = map (
            x: "export ${lib.replaceStrings [ "," "=" ] [ "=" "=" ] x}"
          ) hyprlandEnvList;
        in
        concatStringsSep "\n" modifiedHyprlandEnvVars;

      xdg.configFile."hypr/application-style.conf" = {
        text = config.lib.generators.toHyprconf {
          attrs = {
            # https://wiki.hypr.land/Hypr-Ecosystem/hyprland-qt-support/
            roundness = 2;
          };
        };
      };

      xdg.desktopEntries."org.gnome.Settings" = {
        name = "GNOME Settings";
        comment = "GNOME Control Center";
        icon = "org.gnome.Settings";
        exec = "env XDG_CURRENT_DESKTOP=gnome ${pkgs.gnome-control-center}/bin/gnome-control-center";
        categories = [ "X-Preferences" ];
      };

      programs.fish.completions.uwsm-hyprland = ''
        complete --command uwsm --arguments "hyprland.desktop hyprland-uwsm.desktop" --no-files
      '';
    }

    (mkIf cfg.ttyAutostart {
      programs.bash.profileExtra = ''
        if [[ $(tty) =~ /dev/tty[${cfg.ttyAutostartNumbers}] ]] && uwsm check may-start; then
          exec uwsm start default
        fi
      '';
      programs.zsh.loginExtra = ''
        if [[ $(tty) =~ /dev/tty[${cfg.ttyAutostartNumbers}] ]] && uwsm check may-start; then
          exec uwsm start default
        fi
      '';
      programs.fish.loginShellInit = ''
        if string match --regex --quiet "/dev/tty[${cfg.ttyAutostartNumbers}]" $(tty) && uwsm check may-start
          exec uwsm start default
        end
      '';
    })
  ];
}
