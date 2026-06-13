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
  #meta.doc = builtins.toFile "doc.md" ''
  #  Installs and configures the Hyprland desktop environment.
  #  <https://hypr.land/>
  #  <https://github.com/hyprwm/Hyprland>
  #'';

  imports = with inputs; [
    self.homeModules.noctalia
    self.homeModules.pyprland
    self.homeModules.stylix
    ../desktopEnvironment-common/keybinds.nix
    ../desktopEnvironment-common/mustHaves.nix
    # ./animated-background.nix
    ./hypridle.nix
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
          # plugins.hyprexpo.enable = true;
        };
        pyprland.enable = true;
      };

      home.packages = with pkgs; [
        grimblast
        hyprkeys
        hyprpicker
        hyprprop
        hyprshot
        hyprsysteminfo
        waypaper
        wl-freeze
      ];

      # [Hyprland](https://github.com/hyprwm/Hyprland)
      wayland.windowManager.hyprland = {
        enable = true;
        systemd.enable = false; # conflicts with UWSM

        configType = "lua";

        extraLuaFiles."binds".content = readFile ./binds.lua;
        extraLuaFiles."animations".content = readFile ./animations.lua;

        settings = {
          # [Variables](https://wiki.hypr.land/Configuring/Basics/Variables/)
          config = {
            general = {
              gaps_in = 5;
              gaps_out = 8;
              border_size = 2;
              resize_on_border = true;
              layout = "master";
              "col.active_border" = mkForce "rgb(${config.lib.stylix.colors.base0B})";
            };

            decoration = {
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

            input = {
              # list of options `/usr/share/X11/xkb/rules/base.lst`
              accel_profile = mkDefault "adaptive";
              follow_mouse = 1;
              kb_layout = "de";
              kb_variant = "nodeadkeys";
              numlock_by_default = true;
              repeat_delay = 300;
              repeat_rate = 16;

              touchpad = {
                drag_lock = 1;
              };
            };

            gestures = {
              workspace_swipe_forever = true;
            };

            misc = {
              disable_autoreload = true;
              disable_hyprland_logo = true;
              focus_on_activate = true;
              key_press_enables_dpms = true;
              animate_manual_resizes = true;
              animate_mouse_windowdragging = true;
              background_color = mkForce "rgb(${config.lib.stylix.colors.base01})";
            };

            binds = {
              scroll_event_delay = 150;
              workspace_back_and_forth = true;
              allow_workspace_cycles = true;
            };

            xwayland.force_zero_scaling = true;

            cursor = {
              warp_on_change_workspace = 1;
              zoom_rigid = true;
              persistent_warps = true;
            };

            # [Layouts](https://wiki.hypr.land/Configuring/Layouts/)
            #
            dwindle = {
              force_split = 2;
              preserve_split = true;
              default_split_ratio = 1.25;
            };
          };

          monitor = [
            {
              output = "";
              mode = "preferred";
              position = "auto";
              scale = 1;
            }
          ];

          bind = with pkgs; [
            # Goodies
            {
              _args = [
                "SUPER + ALT + K"
                (mkLuaInline ''hl.dsp.exec_cmd("uwsm app -- ${getExe hyprpicker} | ${wl-clipboard-rs}/bin/wl-copy")'')
                { description = "Pick a color with hyprpicker and copy it to the clipboard"; }
              ];
            }
            {
              _args = [
                "SUPER + Pause"
                (mkLuaInline ''hl.dsp.exec_cmd("uwsm app -- ${getExe wl-freeze} --active")'')
                { description = "(Un-)Freeze the current window"; }
              ];
            }

            # Screenshots
            # GRIMBLAST_HIDE_CURSOR=1: https://github.com/Jas-SinghFSU/HyprPanel/issues/832
            {
              _args = [
                "Print"
                (mkLuaInline ''hl.dsp.exec_cmd("GRIMBLAST_HIDE_CURSOR=1 uwsm app -- ${getExe grimblast} copysave output ${config.xdg.userDirs.pictures}/Screenshots/$(date +'%F-%T_%N.png')")'')
                { description = "Screenshot quick fullscreen | copy & save"; }
              ];
            }
            {
              _args = [
                "SUPER + Print"
                (mkLuaInline ''hl.dsp.exec_cmd("GRIMBLAST_HIDE_CURSOR=1 uwsm app -- ${getExe grimblast} --notify --freeze copysave area ${config.xdg.userDirs.pictures}/Screenshots/$(date +'%F-%T_%N.png')")'')
                { description = "Screenshot select area | copy & save"; }
              ];
            }
            {
              _args = [
                "ALT + Print"
                (mkLuaInline ''hl.dsp.exec_cmd("GRIMBLAST_HIDE_CURSOR=1 uwsm app -- ${getExe grimblast} --notify --freeze --cursor save output - | ${getExe satty} --filename - --fullscreen --output-filename ${config.xdg.userDirs.pictures}/Screenshots/$(date +'%F-%T_%N.png')")'')
                { description = "Screenshot quick fullscreen | edit | save"; }
              ];
            }
            {
              _args = [
                "SUPER + ALT + Print"
                (mkLuaInline ''hl.dsp.exec_cmd("GRIMBLAST_HIDE_CURSOR=1 uwsm app -- ${getExe grimblast} --freeze save area - | ${getExe satty} --filename - --output-filename ${config.xdg.userDirs.pictures}/Screenshots/$(date +'%F-%T_%N.png')")'')
                { description = "Screenshot select area | edit | save"; }
              ];
            }
            {
              _args = [
                "SUPER + T"
                (mkLuaInline ''hl.dsp.exec_cmd("GRIMBLAST_HIDE_CURSOR=1 uwsm app -- ${getExe grimblast} --freeze save area - | ${getExe tesseract} - - -l deu+eng | ${wl-clipboard-rs}/bin/wl-copy")'')
                { description = "Screenshot select area | OCR | copy"; }
              ];
            }
          ];

          window_rule = [
            # https://wiki.hypr.land/Configuring/Basics/Window-Rules
            # https://regex101.com/
            #$ hyprctl clients
            {
              # Another border color for xwayland windows
              match.xwayland = true;
              border_color = "rgb(${config.lib.stylix.colors.base09})";
            }
            {
              # Make inactive floating windows (with titles) more transparent
              match.float = true;
              opacity = "1 0.7";
            }

            {
              match.title = "(A|a)lert";
              float = true;
            }
            {
              match.title = "(S|s)etup";
              float = true;
            }
            {
              match.title = "(P|p)rogress";
              float = true;
            }

            {
              # Disable blur for windows
              match.title = ".+";
              no_blur = true;
            }

            {
              # Bigger border size for pinned windows
              match.pin = true;
              border_size = ceil (
                config.wayland.windowManager.hyprland.settings.config.general.border_size * 1.5
              );
            }
          ];
          layer_rule = [
            {
              match.namespace = ".*";
              xray = true;
            }
            {
              match.namespace = "launcher";
              blur = true;
              ignore_alpha = 0.5;
            }
          ];

          workspace_rule = [ ];

          on = [
            {
              _args = [
                "hyprland.start"
                # [Soteria systemd service does not start](https://github.com/NixOS/nixpkgs/issues/373290)
                (mkLuaInline ''function() hl.exec_cmd("${pkgs.dbus}/bin/dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_ID") end'')
              ];
            }
          ];

          gesture = [
            {
              fingers = 3;
              direction = "vertical";
              action = "workspace";
            }
          ];
        }
        // optionalAttrs cfg.smartGaps {
          workspace_rule = [
            {
              workspace = "w[tv1]";
              gapsout = 0;
              gapsin = 0;
            }
            {
              workspace = "f[1]";
              gapsout = 0;
              gapsin = 0;
            }
          ];
          window_rule = [
            {
              match.float = false;
              match.workspace = "w[tv1]";
              bordersize = 0;
            }
            {
              match.float = false;
              match.workspace = "w[tv1]";
              rounding = 0;
            }
            {
              match.float = false;
              match.workspace = "f[1]";
              bordersize = 0;
            }
            {
              match.float = false;
              match.workspace = "f[1]";
              rounding = 0;
            }
          ];
        };
      };

      # [Environment variables](https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/)
      #` xdg.configFile."uwsm/env-hyprland".text = ''
      #`   export KEY=VAL
      #` '';

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
