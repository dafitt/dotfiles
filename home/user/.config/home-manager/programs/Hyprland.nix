{ config, lib, pkgs, ... }: {

  # current log $ cat /tmp/hypr/$(ls -t /tmp/hypr/ | head -n 2 | tail -n 1)/hyprland.log
  # last log $ cat /tmp/hypr/$(ls -t /tmp/hypr/ | head -n 1)/hyprland.log

  wayland.windowManager.hyprland = {
    enable = true;

    # custom variables
    extraConfig = ''
    '';

    settings = {
      monitor = lib.mkDefault ",preffered,auto,1";
      xwayland.force_zero_scaling = true;

      # Variables
      # <https://wiki.hyprland.org/Configuring/Variables/>
      general = {
        # <https://wiki.hyprland.org/Configuring/Variables/#general>
        gaps_in = 5;
        gaps_out = 8;
        border_size = 2;
        resize_on_border = true;
        cursor_inactive_timeout = 10;
        layout = "dwindle";
      };
      dwindle = {
        # <https://wiki.hyprland.org/Configuring/Dwindle-Layout/>
        pseudotile = true; # master switch for pseudotiling
        force_split = 2;
        preserve_split = true; # you probably want this
      };
      master = {
        # <https://wiki.hyprland.org/Configuring/Master-Layout/>
        new_is_master = false;
      };
      misc = {
        # <https://wiki.hyprland.org/Configuring/Variables/#misc>
        disable_hyprland_logo = true;
        focus_on_activate = true;
        vrr = 0;
        vfr = true;
      };
      decoration = {
        # <https://wiki.hyprland.org/Configuring/Variables/#decoration>
        active_opacity = 0.93;
        inactive_opacity = 0.93;
        rounding = 8;
        dim_inactive = true;
        dim_strength = .1;
        drop_shadow = true;
        shadow_range = 8;
        shadow_render_power = 3;

        blurls = [
          # blurring layerSurfaces
          "launcher"
          "lockscreen"
          "notifications"
        ];
      };
      animations = {
        # <https://wiki.hyprland.org/Configuring/Animations/>
        enabled = true;

        bezier = [
          # Bezier are Curves used in animations
          # "NAME,X0,Y0,X1,Y1"
          "overshot, 0.05, 0.9, 0.1, 1.05"
          "smoothOut, 0.36, 0, 0.66, -0.56"
          "smoothIn, 0.25, 1, 0.5, 1"
        ];
        animation = [
          # "NAME,ONOFF,SPEED,CURVE,STYLE"
          "windows, 1, 5, overshot, slide"
          "windowsOut, 1, 5, overshot, slide"
          #"windowsMove, 1, 4, default"
          "border, 1, 10, default"
          "fade, 1, 5, smoothIn"
          "fadeDim, 1, 5, smoothIn"
          "workspaces, 1, 6, default"
        ];
      };

      input = {
        # <https://wiki.hyprland.org/Configuring/Variables/#input>
        # list of options `/usr/share/X11/xkb/rules/base.lst`
        kb_layout = "de";
        kb_variant = "nodeadkeys";
        numlock_by_default = true;
        follow_mouse = 1;
        sensitivity = 0; # -1.0 to 1.0, 0 means no modification.

        touchpad = {
          #clickfinger_behavior = true;
          drag_lock = true;
          tap-and-drag = true;
        };
      };
      gestures = {
        # <https://wiki.hyprland.org/Configuring/Variables/#gestures>
        workspace_swipe = true;
      };

      binds = {
        # <https://wiki.hyprland.org/Configuring/Variables/#binds>
        workspace_back_and_forth = true;
        scroll_event_delay = 150;
      };

      bind = [
        # <https://wiki.hyprland.org/Configuring/Binds/>
        # <https://wiki.hyprland.org/Configuring/Dispatchers/>

        "CONTROL SUPER, Q, exit," # Exit Hyprland all together (force quit Hyprland)
        "CONTROL SUPER, R, exec, hyprctl reload"
        "SUPER, ODIAERESIS, exec, systemctl suspend" # quick-suspend
        "SUPER, Q, exec, wlogout --protocol layer-shell" # show the logout window

        # Default programs
        "SUPER, RETURN, exec, $TERMINAL"
        "SUPER, F1, exec, $BROWSER"
        "SUPER, F2, exec, $TERMINAL -e $TOP"

        # Window Control
        "SUPER, DELETE, exec, hyprctl kill" # kill a window by clicking it
        "SUPER, X, killactive," # close the active window
        "SUPER, P, pseudo," # dwindle
        "SUPER, J, togglesplit," # dwindle
        "SUPER, F, fullscreen,"
        "SUPER, V, togglefloating," # Allow a window to float
        "SUPER, B, pin,"

        # Move focus with mainMod + arrow keys
        "SUPER, left, movefocus, l"
        "SUPER, right, movefocus, r"
        "SUPER, up, movefocus, u"
        "SUPER, down, movefocus, d"
        "SUPER, Tab, cyclenext,"
        # move
        "SHIFT SUPER, left, movewindow, l"
        "SHIFT SUPER, right, movewindow, r"
        "SHIFT SUPER, up, movewindow, u"
        "SHIFT SUPER, down, movewindow, d"
        "SHIFT SUPER, Tab, swapnext,"
        # resize
        "CTRL SUPER, left, resizeactive, -100 0"
        "CTRL SUPER, right, resizeactive, 100 0"
        "CTRL SUPER, up, resizeactive, 0 -100"
        "CTRL SUPER, down, resizeactive, 0 100"

        # Switch workspaces with
        "SUPER, 1, workspace, 1"
        "SUPER, 2, workspace, 2"
        "SUPER, 3, workspace, 3"
        "SUPER, 4, workspace, 4"
        "SUPER, 5, workspace, 5"
        "SUPER, 6, workspace, 6"
        "SUPER, 7, workspace, 7"
        "SUPER, 8, workspace, 8"
        "SUPER, 9, workspace, 9"
        "SUPER, 0, workspace, 10"
        "SUPER, D, workspace, 11"
        "SUPER, code:87, workspace, 1" # Numpad
        "SUPER, code:88, workspace, 2" # Numpad
        "SUPER, code:89, workspace, 3" # Numpad
        "SUPER, code:83, workspace, 4" # Numpad
        "SUPER, code:84, workspace, 5" # Numpad
        "SUPER, code:85, workspace, 6" # Numpad
        "SUPER, code:79, workspace, 7" # Numpad
        "SUPER, code:80, workspace, 8" # Numpad
        "SUPER, code:81, workspace, 9" # Numpad
        "SUPER, code:91, workspace, 10" # Numpad
        "SUPER, code:86, workspace, +1" # Numpad +
        "SUPER, code:82, workspace, -1" # Numpad -
        "SUPER, backspace, workspace, previous"

        # Move active window to a workspace
        "SHIFT SUPER, 1, movetoworkspacesilent, 1"
        "SHIFT SUPER, 2, movetoworkspacesilent, 2"
        "SHIFT SUPER, 3, movetoworkspacesilent, 3"
        "SHIFT SUPER, 4, movetoworkspacesilent, 4"
        "SHIFT SUPER, 5, movetoworkspacesilent, 5"
        "SHIFT SUPER, 6, movetoworkspacesilent, 6"
        "SHIFT SUPER, 7, movetoworkspacesilent, 7"
        "SHIFT SUPER, 8, movetoworkspacesilent, 8"
        "SHIFT SUPER, 9, movetoworkspacesilent, 9"
        "SHIFT SUPER, 0, movetoworkspacesilent, 10"
        "SHIFT SUPER, code:87, movetoworkspacesilent, 1" # Numpad
        "SHIFT SUPER, code:88, movetoworkspacesilent, 2" # Numpad
        "SHIFT SUPER, code:89, movetoworkspacesilent, 3" # Numpad
        "SHIFT SUPER, code:83, movetoworkspacesilent, 4" # Numpad
        "SHIFT SUPER, code:84, movetoworkspacesilent, 5" # Numpad
        "SHIFT SUPER, code:85, movetoworkspacesilent, 6" # Numpad
        "SHIFT SUPER, code:79, movetoworkspacesilent, 7" # Numpad
        "SHIFT SUPER, code:80, movetoworkspacesilent, 8" # Numpad
        "SHIFT SUPER, code:81, movetoworkspacesilent, 9" # Numpad
        "SHIFT SUPER, code:91, movetoworkspacesilent, 10" # Numpad
        "SHIFT SUPER, code:86, movetoworkspacesilent, +1" # Numpad +
        "SHIFT SUPER, code:82, movetoworkspacesilent, -1" # Numpad -
        "SUPER, mouse_down, workspace, -1"
        "SUPER, mouse_up, workspace, +1"

        # Media keys
        ", XF86AudioPlay, exec, ${pkgs.playerctl}/bin/playerctl play-pause"
        ", XF86AudioPause, exec, ${pkgs.playerctl}/bin/playerctl play-pause"
        ", XF86AudioNext, exec, ${pkgs.playerctl}/bin/playerctl next"
        ", XF86AudioPrev, exec, ${pkgs.playerctl}/bin/playerctl previous"
        ", XF86AudioRaiseVolume, execr, ${pkgs.swayosd}/bin/swayosd --output-volume raise && $XDG_CONFIG_HOME/eww/scripts/update_audioVolume"
        ", XF86AudioLowerVolume, execr, ${pkgs.swayosd}/bin/swayosd --output-volume lower && $XDG_CONFIG_HOME/eww/scripts/update_audioVolume"
        "ALT, XF86AudioRaiseVolume, exec, ${pkgs.swayosd}/bin/swayosd --input-volume raise && $XDG_CONFIG_HOME/eww/scripts/update_microphoneVolume"
        "ALT, XF86AudioLowerVolume, exec, ${pkgs.swayosd}/bin/swayosd --input-volume lower && $XDG_CONFIG_HOME/eww/scripts/update_microphoneVolume"
        "CTRL, XF86AudioRaiseVolume, exec, ${pkgs.playerctl}/bin/playerctl position 1+"
        "CTRL, XF86AudioLowerVolume, exec, ${pkgs.playerctl}/bin/playerctl position 1-"
        ", XF86AudioMute, exec, ${pkgs.swayosd}/bin/swayosd --output-volume mute-toggle && $XDG_CONFIG_HOME/eww/scripts/update_audioMute"
        "ALT, XF86AudioMute, exec, ${pkgs.swayosd}/bin/swayosd --input-volume mute-toggle && $XDG_CONFIG_HOME/eww/scripts/update_microphoneMute"
        ", XF86AudioMicMute, exec, ${pkgs.swayosd}/bin/swayosd --input-volume mute-toggle && $XDG_CONFIG_HOME/eww/scripts/update_microphoneMute"
        ", XF86MonBrightnessUp, exec, ${pkgs.swayosd}/bin/swayosd --brightness raise && $XDG_CONFIG_HOME/eww/scripts/update_brightness"
        ", XF86MonBrightnessDown, exec, ${pkgs.swayosd}/bin/swayosd --brightness lower && $XDG_CONFIG_HOME/eww/scripts/update_brightness"
        ", XF86KbdBrightnessUp, exec, ${pkgs.light}/bin/light -s sysfs/leds/kbd_backlight -A 10"
        ", XF86KbdBrightnessDown, exec, ${pkgs.light}/bin/light -s sysfs/leds/kbd_backlight -U 10"
        ", Caps_Lock, exec, ${pkgs.swayosd}/bin/swayosd --caps-lock"

        # Screenshots
        "SUPER, Print, exec, ${pkgs.grim}/bin/grim $XDG_SCREENSHOTS_DIR/$(date +'%s.png')" # quick all
        "SUPER, S, exec, ${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp -o)\" $XDG_SCREENSHOTS_DIR/$(date +'%s.png')" # quick monitor
        "SUPER CTRL, S, exec, ${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp)\" $XDG_SCREENSHOTS_DIR/$(date +'%s.png')" # quick select
        "SUPER ALT, S, exec, ${pkgs.grim}/bin/grim - | ${pkgs.swappy}/bin/swappy -f -" # all swappy
        "SUPER ALT CTRL, S, exec, ${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp)\" - | ${pkgs.swappy}/bin/swappy -f -" # select swappy

        # some small helper programs
        "ALT SUPER, U, exec, ${pkgs.gnome.gnome-characters}/bin/gnome-characters"
        "ALT SUPER, K, exec, ${pkgs.hyprpicker}/bin/hyprpicker"
      ];
      bindm = [
        # Move/resize windows with mainMod + LMB/RMB and dragging
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];

      windowrulev2 = [
        # <https://wiki.hyprland.org/Configuring/Window-Rules/>
        # <https://regex101.com/>
        #$ hyprctl clients
        "opacity 1 0.7, floating:1, title:(.)+" # make inactive floating windows (with titles) more transparent

        "float, title:(S|s)etup"
        "float, title:(P|p)rogress"
        "float, class:nm-connection-editor"
      ];

      # only on launch
      exec-once = [
        # fix for some commands doesnt exec-once, see: Issue <https://github.com/hyprwm/Hyprland/issues/1906>
        "systemctl --user import-environment XDG_SESSION_TYPE XDG_CURRENT_DESKTOP"
        "dbus-update-activation-environment --all"

        "~/.config/hypr/hyprland.monitors.sh" # set monitor sizes

        # some system services
        "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1" # start polkit manually (isn't done automatically)
        "${pkgs.swayosd}/bin/swayosd"
        "hyprctl setcursor ${config.gtk.cursorTheme.name} ${builtins.toString config.gtk.cursorTheme.size}"
        "nm-applet" # for notifications about network
      ];
      # only on each reload
      exec = [
        "~/.config/hypr/hyprland.monitors.sh" # set monitor sizes
      ];

      # <https://wiki.hyprland.org/Configuring/Environment-variables/>
      env = [
        # <https://wiki.hyprland.org/FAQ/>

        #XDG
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"

        # QT
        "QT_AUTO_SCREEN_SCALE_FACTOR,1"
        "QT_QPA_PLATFORM=wayland;xcb"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"

        # Toolkit
        "SDL_VIDEODRIVER,wayland"
        "_JAVA_AWT_WM_NONEREPARENTING,1"
        "CLUTTER_BACKEND,wayland"
        "GDK_BACKEND,wayland,x11"
      ];
    };


  };
  # TODO import additional Hyprland.conf for a specific host
  #extraConfig = (import "./hyprland.${config.networking.hostName}.nix" {
  #  inherit (config);
  #});
  home.file.".config/hypr/hyprland.monitors.sh".source = ./hyprland.monitors.sh;

  # Extend Wayland / Hyprland
  # - Awesome Hyprland <https://github.com/hyprland-community/awesome-hyprland>
  # - Awesome Wayland <https://github.com/natpen/awesome-wayland>
}