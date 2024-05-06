{ options, config, lib, pkgs, inputs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.desktops.hyprland;
  osCfg = osConfig.dafitt.desktops.hyprland or null;
in
{
  options.dafitt.desktops.hyprland = with types; {
    enable = mkBoolOpt (osCfg.enable or false) "Enable the Hyprland desktop";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; with inputs; [
      grimblast # A helper for screenshots within Hyprland, based on grimshot
      hyprkeys # A simple, fast and scriptable keybind inspection utility
      hyprpicker # A wlroots-compatible Wayland color picker that does not suck
    ];

    # current log $ cat /tmp/hypr/$(ls -t /tmp/hypr/ | head -n 2 | tail -n 1)/hyprland.log
    # last log $ cat /tmp/hypr/$(ls -t /tmp/hypr/ | head -n 1)/hyprland.log

    # [Hyprland](https://github.com/hyprwm/Hyprland) is a highly customizable
    # dynamic tiling Wayland compositor that doesn't sacrifice on its looks.
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = true;

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
          #allow_tearing = true; # TODO: 24.05 enable (immediate windowrule)
        };
        dwindle = {
          # https://wiki.hyprland.org/Configuring/Dwindle-Layout/
          pseudotile = true; # master switch for pseudotiling
          force_split = 2;
          preserve_split = true; # you probably want this
          default_split_ratio = 1.25; # 0.1 - 1.9
          no_gaps_when_only = 1; # without border
        };
        master = {
          # https://wiki.hyprland.org/Configuring/Master-Layout/
          new_is_master = false;
        };
        misc = {
          # https://wiki.hyprland.org/Configuring/Variables/#misc
          disable_autoreload = true;
          disable_hyprland_logo = true;
          focus_on_activate = true;
          key_press_enables_dpms = true;
          animate_manual_resizes = true;
          animate_mouse_windowdragging = true;
        };
        decoration = {
          # https://wiki.hyprland.org/Configuring/Variables/#decoration
          active_opacity = 0.93;
          inactive_opacity = 0.93;

          rounding = 16;

          dim_inactive = true;
          dim_strength = .1;

          shadow_range = 16;
          shadow_render_power = 2;
          "col.shadow" = mkForce "rgb(${config.lib.stylix.colors.base01})";
          "col.shadow_inactive" = "rgba(00000000)";

          blurls = [
            # blurring layerSurfaces
            "launcher"
            "lockscreen"
          ];
        };
        animations = {
          # https://wiki.hyprland.org/Configuring/Animations/
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
          # https://wiki.hyprland.org/Configuring/Variables/#input
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
          # https://wiki.hyprland.org/Configuring/Variables/#gestures
          workspace_swipe = true;
        };

        binds = {
          # https://wiki.hyprland.org/Configuring/Variables/#binds
          workspace_back_and_forth = true;
          scroll_event_delay = 150;
        };

        bind = with pkgs; with inputs; [
          # https://wiki.hyprland.org/Configuring/Binds/
          # https://wiki.hyprland.org/Configuring/Dispatchers/

          "SUPER_CONTROL, Q, exit," # Exit Hyprland all together (force quit Hyprland)
          "SUPER_CONTROL, R, exec, hyprctl reload && forcerendererreload"
          "SUPER_CONTROL, ADIAERESIS, exec, poweroff" # quick-poweroff
          "SUPER_CONTROL, ODIAERESIS, exec, poweroff --reboot" # quick-reboot
          "SUPER, ODIAERESIS, dpms, off"
          "SUPER, UDIAERESIS, exec, systemctl suspend" # quick-suspend

          # Window Control
          "SUPER, DELETE, exec, hyprctl kill" # kill a window by clicking it
          "SUPER, X, killactive," # close the active window
          "SUPER, P, pseudo," # dwindle
          "SUPER, S, togglesplit," # dwindle
          "SUPER, H, swapnext,"
          "SUPER_SHIFT, H, swapnext, prev"
          "SUPER, F, fullscreen,"
          "SUPER, A, fullscreen, 1" # maximize only
          "SUPER, V, togglefloating," # Allow a window to float
          "SUPER, B, pin,"

          # Move focus with mainMod + arrow keys
          "SUPER, left, movefocus, l"
          "SUPER, right, movefocus, r"
          "SUPER, up, movefocus, u"
          "SUPER, down, movefocus, d"
          "SUPER, Tab, cyclenext,"
          # move
          "SUPER_SHIFT, left, movewindow, l"
          "SUPER_SHIFT, right, movewindow, r"
          "SUPER_SHIFT, up, movewindow, u"
          "SUPER_SHIFT, down, movewindow, d"
          "SUPER_SHIFT, Tab, swapnext,"
          # resize
          "SUPER_CTRL, left, resizeactive, -100 0"
          "SUPER_CTRL, right, resizeactive, 100 0"
          "SUPER_CTRL, up, resizeactive, 0 -100"
          "SUPER_CTRL, down, resizeactive, 0 100"

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
          "SUPER, D, workspace, name:D"
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
          "SUPER, mouse_down, workspace, -1"
          "SUPER, mouse_up, workspace, +1"

          # Screenshots
          ", PRINT, exec, ${grimblast}/bin/grimblast copysave output ${config.xdg.userDirs.pictures}/$(date +'%F-%T_%N.png')" # QUICK FULLSCREEN
          "CONTROL, PRINT, exec, ${grimblast}/bin/grimblast --notify --freeze copysave area ${config.xdg.userDirs.pictures}/$(date +'%F-%T_%N.png')" # SELECT AREA
          # TODO: 24.05 [satty](https://github.com/gabm/satty?tab=readme-ov-file#wlroots-based-compositors-sway-hyprland-wayfire-river-)
          "ALT, PRINT, exec, ${grimblast}/bin/grimblast --notify --freeze --cursor save output - | ${swappy}/bin/swappy -f - -o ${config.xdg.userDirs.pictures}/$(date +'%F-%T_%N.png')" # QUICK FULLSCREEN | EDIT
          "ALT CONTROL, PRINT, exec, ${grimblast}/bin/grimblast --freeze save area - | ${swappy}/bin/swappy -f - -o ${config.xdg.userDirs.pictures}/$(date +'%F-%T_%N.png')" # SELECT AREA | EDIT

          # some small helper programs
          "SUPER_ALT, U, exec, ${gnome.gnome-characters}/bin/gnome-characters"
          "SUPER_ALT, K, exec, ${hyprpicker}/bin/hyprpicker | ${wl-clipboard}/bin/wl-copy" # TODO: 24.05 replace wl-clipboard-rs
        ];

        # Bind: mouse binds
        bindm = [
          # Move/resize windows with mainMod + LMB/RMB and dragging
          "SUPER, mouse:272, movewindow"
          "SUPER, mouse:273, resizewindow"
        ];

        # Bind: repeat while holding
        binde = [
          # Media Keys
          ", XF86KbdBrightnessUp, exec, ${pkgs.light}/bin/light -s sysfs/leds/kbd_backlight -A 10"
          ", XF86KbdBrightnessDown, exec, ${pkgs.light}/bin/light -s sysfs/leds/kbd_backlight -U 10"
        ];

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
        ];

        # only on launch
        exec-once = [
          # [Some of my apps take a really long time to open…?](https://wiki.hyprland.org/FAQ/#some-of-my-apps-take-a-really-long-time-to-open)
          "${pkgs.dbus}/bin/dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
          "${pkgs.systemd}/bin/systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"

          #"${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1" # start polkit manually (isn't done automatically)
          "${pkgs.wluma}/bin/wluma"
        ];

        # on each reload
        exec = [ ];

        # https://wiki.hyprland.org/Configuring/Environment-variables/
        env = [
          # https://wiki.hyprland.org/FAQ/

          # XDG Specifications
          "XDG_CURRENT_DESKTOP=Hyprland"
          "XDG_SESSION_TYPE,wayland"
          "XDG_SESSION_DESKTOP,Hyprland"

          # QT
          "QT_AUTO_SCREEN_SCALE_FACTOR,1" # enable automatic scaling
          "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        ];
      };
    };

    # Autostart Hyprland from tty
    programs.bash.profileExtra = ''
      if [[ -z $DISPLAY && $(tty) =~ /dev/tty[1-4] && $XDG_SESSION_TYPE == tty ]]; then
          exec Hyprland
      fi
    '';
    programs.zsh.loginExtra = ''
      if [[ -z $DISPLAY && $(tty) =~ /dev/tty[1-4] && $XDG_SESSION_TYPE == tty ]]; then
          exec Hyprland
      fi
    '';
    programs.fish.loginShellInit = ''
      if test -z $DISPLAY; and tty | string match -r "/dev/tty[1-4]"; and test $XDG_SESSION_TYPE = tty
          exec Hyprland
      end
    '';
  };
}
