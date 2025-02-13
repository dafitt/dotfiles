{ options, config, lib, pkgs, inputs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.hyprland;
  osCfg = osConfig.dafitt.hyprland or null;
in
{
  options.dafitt.hyprland = with types; {
    enable = mkBoolOpt (osCfg.enable or false) "Whether to enable the Hyprland desktop.";

    smartGaps = mkEnableOption "smart gaps workspace rules (no gaps when only one window on workspace)";
    ttyAutostart = mkBoolOpt true "Whether to autostart Hyprland from a tty after login.";
  };

  config = mkMerge [
    (mkIf cfg.enable {
      dafitt = {
        stylix.enable = true;
      } // (mkDefault {
        gnome-calculator.enable = true;
        hyprland.cliphist.enable = true;
        hyprland.hypridle.enable = true;
        hyprland.hyprlock.enable = true;
        hyprland.pyprland.enable = true;
        hyprland.themes.hyprpanel.enable = true;
        hyprland.wlsunset.enable = true;
        launchers.default = "fuzzel";
        playerctld.enable = true;
      });

      home.packages = with pkgs; with inputs; [
        grimblast # A helper for screenshots within Hyprland, based on grimshot
        hyprkeys # A simple, fast and scriptable keybind inspection utility
        hyprpicker # A wlroots-compatible Wayland color picker that does not suck
        hyprsysteminfo # A tiny qt6/qml application to display information about the running system
        waypaper # GUI wallpaper setter for Wayland-based window managers
      ];

      # [Hyprland](https://github.com/hyprwm/Hyprland)
      wayland.windowManager.hyprland = {
        enable = true;
        systemd.enable = false; # conflicts with UWSM

        settings = {
          # [Variables](https://wiki.hyprland.org/Configuring/Variables/)

          xwayland.force_zero_scaling = true;

          general = {
            # https://wiki.hyprland.org/Configuring/Variables/#general
            gaps_in = 5;
            gaps_out = 8;
            border_size = 2;
            resize_on_border = true;
            layout = "dwindle";
            "col.active_border" = mkForce "rgb(${config.lib.stylix.colors.base0A})";
          };
          dwindle = {
            # https://wiki.hyprland.org/Configuring/Dwindle-Layout/
            pseudotile = true; # master switch for pseudotiling
            force_split = 2;
            preserve_split = true; # you probably want this
            default_split_ratio = 1.25; # 0.1 - 1.9
          };
          misc = {
            # https://wiki.hyprland.org/Configuring/Variables/#misc
            disable_autoreload = true;
            disable_hyprland_logo = true;
            focus_on_activate = true;
            key_press_enables_dpms = true;
            animate_manual_resizes = true;
            animate_mouse_windowdragging = true;
            background_color = mkForce "rgb(${config.lib.stylix.colors.base01})";
          };
          decoration = {
            # https://wiki.hyprland.org/Configuring/Variables/#decoration
            #active_opacity = 0.97;
            #inactive_opacity = 0.97;

            rounding = 16;

            dim_inactive = true;
            dim_strength = .1;

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
            # https://wiki.hyprland.org/Configuring/Animations/
            enabled = true;

            bezier = [
              # Used in animation `CURVE`
              # "NAME,X0,Y0,X1,Y1"
              # https://www.cssportal.com/css-cubic-bezier-generator/
              "ease,.25,.1,.25,1"
              "easeIn,.42,0,1,1"
              "easeInOut,.58,.28,.52,.95"
              "easeInOutBack,.68,-.55,.265,1.55"
              "easeInOutQuart,.77,0,.175,1"
              "easeOut,0,0,.58,1"
              "easeOutBack,.175,.885,.32,1.275"
              "easeOutCirc,.075,.82,.165,1"
              "easeOutCubic,.215,.61,.355,1"
              "easeOutExpo,.19,1,.22,1"
              "easeOutQuad,.25,.46,.45,.94"
              "easeOutQuart,.165,.84,.44,1"
              "easeOutQuint,.23,1,.32,1"
              "easeOutSine,.39,.575,.565,1"
              "linear,0,0,1,1"
            ];
            animation = [
              # "NAME,ONOFF,SPEED,CURVE,STYLE"
              "global,      1,  5, easeOutExpo"
              "windows,     1,  5, easeOutExpo, popin"
              "layers,      1,  5, easeOutExpo, slide"
              "workspaces,  1,  7.5, easeOutExpo, slidefade 5%"
            ];
          };

          windowrulev2 = [
            # https://wiki.hyprland.org/Configuring/Window-Rules/
            # https://regex101.com/
            #$ hyprctl clients
            "opacity 1 0.7, floating:1, title:(.)+, xwayland:0" # make inactive floating windows (with titles) more transparent
            "bordercolor rgb(${config.lib.stylix.colors.base09}), xwayland:1" # other border color for xwayland windows

            "float, title:(A|a)lert"
            "float, title:(S|s)etup"
            "float, title:(P|p)rogress"
            "float, class:nm-connection-editor"

            "noblur, title:.*" # Disables blur for windows. Substantially improves performance.
          ];
          layerrule = [
            "xray 1, .*"
            "blur, launcher"
            "ignorealpha 0.5, launcher"
          ];
          workspace = [ ];

          input = {
            # https://wiki.hyprland.org/Configuring/Variables/#input
            # list of options `/usr/share/X11/xkb/rules/base.lst`
            kb_layout = "de";
            kb_variant = "nodeadkeys";
            numlock_by_default = true;
            follow_mouse = 1;
            accel_profile = "adaptive";

            touchpad = {
              #clickfinger_behavior = true;
              drag_lock = true;
              tap-and-drag = true;
            };
          };
          cursor = {
            warp_on_change_workspace = 1;
            zoom_rigid = true;
            hide_on_key_press = true;
            warp_back_after_non_mouse_input = true;
          };
          gestures = {
            # https://wiki.hyprland.org/Configuring/Variables/#gestures
            workspace_swipe = true;
            workspace_swipe_forever = true;
          };

          binds = {
            # https://wiki.hyprland.org/Configuring/Variables/#binds
            workspace_back_and_forth = true;
            allow_workspace_cycles = true;
            scroll_event_delay = 150;
          };

          bind = with pkgs; [
            # https://wiki.hyprland.org/Configuring/Binds/
            # https://wiki.hyprland.org/Configuring/Dispatchers/

            "SUPER_CONTROL, Q, exec, uwsm stop" # Exit Hyprland all together
            "SUPER_CONTROL, R, exec, hyprctl reload; forcerendererreload"
            "SUPER_CONTROL, ADIAERESIS, exec, poweroff" # quick-poweroff
            "SUPER_CONTROL, ODIAERESIS, exec, poweroff --reboot" # quick-reboot
            "SUPER, UDIAERESIS, exec, systemctl suspend" # quick-suspend
            "SUPER, ODIAERESIS, exec, sleep 0.5 && hyprctl dispatch dpms off" # screen off

            # Window control
            "SUPER, DELETE, exec, hyprctl kill" # kill a window by clicking it
            "SUPER, X, killactive," # close the active window
            "SUPER_SHIFT, X, forcekillactive," # kill the active window
            "SUPER, P, pseudo," # dwindle
            "SUPER, R, togglesplit," # dwindle
            "SUPER, H, swapnext,"
            "SUPER_SHIFT, H, swapnext, prev"
            "SUPER, F, fullscreen,"
            "SUPER, A, fullscreen, 1" # maximize only
            "SUPER, V, togglefloating," # Allow a window to float
            "SUPER, Z, alterzorder, top" # floating only
            "SUPER_SHIFT, Z, alterzorder, bottom" # floating only
            "SUPER, B, pin," # floating only
            "SUPER, left, movefocus, l"
            "SUPER, right, movefocus, r"
            "SUPER, up, movefocus, u"
            "SUPER, down, movefocus, d"
            (mkIf (!cfg.plugins.hycov.enable) "SUPER, Tab, cyclenext,")
            "SUPER, Tab, cyclenext, prev"
            "SUPER_SHIFT, left, swapwindow, l"
            "SUPER_SHIFT, right, swapwindow, r"
            "SUPER_SHIFT, up, swapwindow, u"
            "SUPER_SHIFT, down, swapwindow, d"
            "SUPER_SHIFT, Tab, swapnext,"
            "SUPER_ALT, plus, resizeactive, 100 0"
            "SUPER_ALT, minus, resizeactive, -100 0"
            "SUPER_ALT, right, resizeactive, 100 0"
            "SUPER_ALT, left, resizeactive, -100 0"
            "SUPER_ALT, down, resizeactive, 0 100"
            "SUPER_ALT, up, resizeactive, 0 -100"
            # Window groups
            "SUPER_CONTROL, G, togglegroup,"
            "SUPER, G, changegroupactive, f"
            "SUPER_SHIFT, G, changegroupactive, f"
            "SUPER_SHIFT_CONTROL, left, movewindoworgroup, l"
            "SUPER_SHIFT_CONTROL, right, movewindoworgroup, r"
            "SUPER_SHIFT_CONTROL, up, movewindoworgroup, u"
            "SUPER_SHIFT_CONTROL, down, movewindoworgroup, d"

          ] ++ optionals (!any (config: config.enable) [ cfg.plugins.hyprsplit cfg.plugins.hyprnome ]) [
            # Workspace control
            "SUPER, 1, focusworkspaceoncurrentmonitor, 1"
            "SUPER, 2, focusworkspaceoncurrentmonitor, 2"
            "SUPER, 3, focusworkspaceoncurrentmonitor, 3"
            "SUPER, 4, focusworkspaceoncurrentmonitor, 4"
            "SUPER, 5, focusworkspaceoncurrentmonitor, 5"
            "SUPER, 6, focusworkspaceoncurrentmonitor, 6"
            "SUPER, 7, focusworkspaceoncurrentmonitor, 7"
            "SUPER, 8, focusworkspaceoncurrentmonitor, 8"
            "SUPER, 9, focusworkspaceoncurrentmonitor, 9"
            "SUPER, 0, focusworkspaceoncurrentmonitor, 10"
            "SUPER, D, focusworkspaceoncurrentmonitor, name:D" # desktop only
            "SUPER, code:87, focusworkspaceoncurrentmonitor, 1" # Numpad
            "SUPER, code:88, focusworkspaceoncurrentmonitor, 2" # Numpad
            "SUPER, code:89, focusworkspaceoncurrentmonitor, 3" # Numpad
            "SUPER, code:83, focusworkspaceoncurrentmonitor, 4" # Numpad
            "SUPER, code:84, focusworkspaceoncurrentmonitor, 5" # Numpad
            "SUPER, code:85, focusworkspaceoncurrentmonitor, 6" # Numpad
            "SUPER, code:79, focusworkspaceoncurrentmonitor, 7" # Numpad
            "SUPER, code:80, focusworkspaceoncurrentmonitor, 8" # Numpad
            "SUPER, code:81, focusworkspaceoncurrentmonitor, 9" # Numpad
            "SUPER, code:91, focusworkspaceoncurrentmonitor, 10" # Numpad
            "SUPER, code:86, focusworkspaceoncurrentmonitor, +1" # Numpad +
            "SUPER, code:82, focusworkspaceoncurrentmonitor, -1" # Numpad -
            "SUPER, backspace, focusworkspaceoncurrentmonitor, previous"
            "SUPER, mouse_down, focusworkspaceoncurrentmonitor, -1"
            "SUPER, mouse_up, focusworkspaceoncurrentmonitor, +1"

            # Move active window to a workspace
            "SUPER_SHIFT, 1, movetoworkspacesilent, 1"
            "SUPER_SHIFT, 2, movetoworkspacesilent, 2"
            "SUPER_SHIFT, 3, movetoworkspacesilent, 3"
            "SUPER_SHIFT, 4, movetoworkspacesilent, 4"
            "SUPER_SHIFT, 5, movetoworkspacesilent, 5"
            "SUPER_SHIFT, 6, movetoworkspacesilent, 6"
            "SUPER_SHIFT, 7, movetoworkspacesilent, 7"
            "SUPER_SHIFT, 8, movetoworkspacesilent, 8"
            "SUPER_SHIFT, 9, movetoworkspacesilent, 9"
            "SUPER_SHIFT, 0, movetoworkspacesilent, 10"
            "SUPER_SHIFT, code:87, movetoworkspacesilent, 1" # Numpad
            "SUPER_SHIFT, code:88, movetoworkspacesilent, 2" # Numpad
            "SUPER_SHIFT, code:89, movetoworkspacesilent, 3" # Numpad
            "SUPER_SHIFT, code:83, movetoworkspacesilent, 4" # Numpad
            "SUPER_SHIFT, code:84, movetoworkspacesilent, 5" # Numpad
            "SUPER_SHIFT, code:85, movetoworkspacesilent, 6" # Numpad
            "SUPER_SHIFT, code:79, movetoworkspacesilent, 7" # Numpad
            "SUPER_SHIFT, code:80, movetoworkspacesilent, 8" # Numpad
            "SUPER_SHIFT, code:81, movetoworkspacesilent, 9" # Numpad
            "SUPER_SHIFT, code:91, movetoworkspacesilent, 10" # Numpad
            "SUPER_SHIFT, code:86, movetoworkspacesilent, +1" # Numpad +
            "SUPER_SHIFT, code:82, movetoworkspacesilent, -1" # Numpad -

          ] ++ optionals (!cfg.plugins.hyprsplit.enable) [
            # Monitor control
            "SUPER_CTRL, left, movecurrentworkspacetomonitor, l"
            "SUPER_CTRL, right, movecurrentworkspacetomonitor, r"
            "SUPER_CTRL, up, movecurrentworkspacetomonitor, u"
            "SUPER_CTRL, down, movecurrentworkspacetomonitor, d"

          ] ++ [
            # some small helper programs
            "SUPER_ALT, U, exec, ${gnome-characters}/bin/gnome-characters"
            "SUPER_ALT, K, exec, ${getExe hyprpicker} | ${wl-clipboard-rs}/bin/wl-copy"

            # Audio
            ", XF86AudioMute, exec, ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
            "ALT, XF86AudioMute, exec, ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
            ", XF86AudioMicMute, exec, ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"

            # Screenshots
            ", PRINT, exec, ${getExe grimblast} copysave output ${config.xdg.userDirs.pictures}/Screenshots/$(date +'%F-%T_%N.png')" # QUICK FULLSCREEN
            "SUPER, PRINT, exec, ${getExe grimblast} --notify --freeze copysave area ${config.xdg.userDirs.pictures}/Screenshots/$(date +'%F-%T_%N.png')" # SELECT AREA
            "ALT, PRINT, exec, ${getExe grimblast} --notify --freeze --cursor save output - | ${getExe satty} --filename - --fullscreen --output-filename ${config.xdg.userDirs.pictures}/Screenshots/$(date +'%F-%T_%N.png')" # QUICK FULLSCREEN | EDIT
            "SUPER_ALT, PRINT, exec, ${getExe grimblast} --freeze save area - | ${getExe satty} --filename - --output-filename ${config.xdg.userDirs.pictures}/Screenshots/$(date +'%F-%T_%N.png')" # SELECT AREA | EDIT
          ];

          # Bind: mouse binds
          bindm = [
            # Move/resize windows with mainMod + LMB/RMB and dragging
            "SUPER, mouse:272, movewindow"
            "SUPER, mouse:273, resizewindow"
          ];

          # Bind: repeat while holding
          binde = [
            # Audio
            ", XF86AudioRaiseVolume, exec, ${pkgs.wireplumber}/bin/wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 2.5%+"
            ", XF86AudioLowerVolume, exec, ${pkgs.wireplumber}/bin/wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 2.5%-"
            "ALT, XF86AudioRaiseVolume, exec, ${pkgs.wireplumber}/bin/wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SOURCE@ 2.5%+"
            "ALT, XF86AudioLowerVolume, exec, ${pkgs.wireplumber}/bin/wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SOURCE@ 2.5%-"

            # Keyboard
            ", XF86KbdBrightnessUp, exec, ${pkgs.light}/bin/light -s sysfs/leds/kbd_backlight -A 10"
            ", XF86KbdBrightnessDown, exec, ${pkgs.light}/bin/light -s sysfs/leds/kbd_backlight -U 10"

            # Monitor
            ", XF86MonBrightnessUp, exec, ${pkgs.light}/bin/light -U 5"
            ", XF86MonBrightnessDown, exec, ${pkgs.light}/bin/light -A 5"
          ];

          # only on launch
          exec-once = [
            # [Some of my apps take a really long time to open…?](https://wiki.hyprland.org/FAQ/#some-of-my-apps-take-a-really-long-time-to-open)
            #"sleep 1 && ${pkgs.dbus}/bin/dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
            #"${pkgs.systemd}/bin/systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"

            "uwsm app -- ${pkgs.wluma}/bin/wluma"
            "uwsm app -- ${pkgs.udiskie}/bin/udiskie --no-automount --tray &"
          ];

          # on each reload
          exec = [ ];

          monitor = [ ", preferred, auto, 1" ];
        } // optionalAttrs cfg.smartGaps {
          workspace = [
            "w[tv1], gapsout:0, gapsin:0"
            "f[1], gapsout:0, gapsin:0"
          ];
          windowrulev2 = [
            "bordersize 0, floating:0, onworkspace:w[tv1]"
            "rounding 0, floating:0, onworkspace:w[tv1]"
            "bordersize 0, floating:0, onworkspace:f[1]"
            "rounding 0, floating:0, onworkspace:f[1]"
          ];
        };
      };

      systemd.user.services."polkit-hyprpolkitagent" = {
        # It is required for GUI applications to be able to request elevated privileges.
        Unit = {
          Description = "Hyprland Polkit authentication agent";
          Documentation = "https://wiki.hyprland.org/Hypr-Ecosystem/hyprpolkitagent/";
          PartOf = [ "wayland-session@Hyprland.target" ];
        };
        Service = {
          ExecStart = "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent";
          Restart = "always";
          RestartSec = 2;
          TimeoutStopSec = 10;
        };
        Install.WantedBy = [ "wayland-session@Hyprland.target" ];
      };

      # https://wiki.hyprland.org/Configuring/Environment-variables/
      #` export KEY=VAL
      xdg.configFile."uwsm/env" = {
        text = '''';
      };
      xdg.configFile."uwsm/env-hyprland" = {
        text = '''';
      };

      xdg.configFile."hypr/application-style.conf" = {
        text = config.lib.generators.toHyprconf {
          attrs = {
            # https://wiki.hyprland.org/Hypr-Ecosystem/hyprland-qt-support/
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
    })
    (mkIf cfg.ttyAutostart {
      programs.bash.profileExtra = ''
        if uwsm check may-start && uwsm select; then
          exec systemd-cat -t uwsm_start uwsm start default
        fi
      '';
      programs.zsh.loginExtra = ''
        if uwsm check may-start && uwsm select; then
          exec systemd-cat -t uwsm_start uwsm start default
        fi
      '';
      programs.fish.loginShellInit = ''
        if uwsm check may-start && uwsm select
          systemd-cat -t uwsm_start uwsm start default
        end
      '';
    })
  ];
}
