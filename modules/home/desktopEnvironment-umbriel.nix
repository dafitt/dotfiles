{
  flake,
  lib,
  inputs,
  pkgs,
  config,
  ...
}:
with lib;
let
  cfg = config.dafitt.desktopEnvironment-umbriel;
in
{
  #meta.doc = builtins.toFile "doc.md" ''
  #  Installs and configures the Umbriel desktop environment.
  #  <https://github.com/noctalia-dev/umbriel>
  #  <https://docs.noctalia.dev/umbriel/>
  #'';

  imports = with inputs; [
    # umbriel.homeModules.default see modules/home/imports.nix

    self.homeModules.home-manager-mutableFiles
    # self.homeModules.stylix
    desktopEnvironment-common/keybinds.nix
    desktopEnvironment-common/mustHaves.nix
  ];

  options.dafitt.desktopEnvironment-umbriel = with types; {
    smartGaps = mkEnableOption "smart gaps workspace rules (no gaps when only one window on workspace)";

    ttyAutostart = mkOption {
      type = bool;
      default = true;
      description = "Whether to autostart Umbriel from a tty after login.";
    };
    ttyAutostartNumbers = mkOption {
      type = strMatching "^[[:digit:],]*$";
      default = "2";
      description = "TTY numbers on where to autostart from after login. Bash strings [] syntax. e.g. `1-2,7`";
    };
  };

  config = mkMerge [
    {
      programs.umbriel = {
        enable = true;

        settings = {
          general = {
            show_cheatsheet = false;
          };

          layout = {
            mode = "master";
          };

          scratchpad = [
            { name = "minimized"; }
          ];

          workspaces.back_and_forth = true;

          input = {
            window_drag_toggle = "pinned";
            focus.follows_mouse = true;
          };

          input.cursor = {
            size = 32;
            follows_focus = true;
            hide_when_typing = true;
          };

          input.keyboard = {
            layout = "de";
            variant = "nodeadkeys";
            numlock_toggle = true;
            repeat_delay = 300;
            repeat_rate = 16;
          };

          keybinds = {
            # Help
            "Mod+Question" = "cheatsheet-toggle";
            "Mod+Ssharp" = "cheatsheet-toggle";
            "Mod+F1" = "cheatsheet-toggle";

            # Session and system control
            "Mod+Escape" = "session-quit";
            "Mod+Control+R" = "config-reload";
            "Mod+Odiaeresis" = "dpms-off";

            # Window focus and movement
            "Mod+Left" = "window-focus-or-output-left";
            "Mod+Right" = "window-focus-or-output-right";
            "Mod+Up" = "window-focus-or-output-up";
            "Mod+Down" = "window-focus-or-output-down";
            "Mod+Home" = "column-focus-first";
            "Mod+End" = "column-focus-last";
            "Mod+Tab" = "window-focus-next";
            "Mod+Shift+Tab" = "window-focus-previous";
            "Mod+Shift+Left" = "window-move-or-output-left";
            "Mod+Shift+Right" = "window-move-or-output-right";
            "Mod+Shift+Up" = "window-move-or-output-up";
            "Mod+Shift+Down" = "window-move-or-output-down";
            "Mod+Shift+Home" = "column-move-to-first";
            "Mod+Shift+End" = "column-move-to-last";
            "Mod+H" = {
              action = "window-swap-next";
              repeat = false;
            };
            "Mod+Shift+H" = {
              action = "window-swap-previous";
              repeat = false;
            };

            "Mod+Plus" = "window-modify-primary-extent:+0.1";
            "Mod+Minus" = "window-modify-primary-extent:-0.1";
            "Mod+Shift+Plus" = "window-modify-secondary-extent:+0.1";
            "Mod+Shift+Minus" = "window-modify-secondary-extent:-0.1";

            # Window state and layout
            "Mod+X" = {
              action = "window-close";
              repeat = false;
            };
            "Mod+V" = {
              action = "window-toggle-floating";
              repeat = false;
            };
            "Mod+P" = {
              action = "window-toggle-pinned";
              repeat = false;
            };
            "Mod+A" = {
              action = "window-toggle-maximize";
              repeat = false;
            };
            "Mod+F" = {
              action = "window-toggle-fullscreen";
              repeat = false;
            };
            "Mod+Asciicircum" = {
              action = "overview-toggle";
            };
            "Mod+Pause" = "spawn:${getExe pkgs.wl-freeze} --notif-timeout 600 --pid $(umbriel windows --json | ${getExe pkgs.jq} --raw-output '.[] | select (.active) | .pid')";

            # Workspaces
            "Mod+1" = "workspace-switch:1";
            "Mod+2" = "workspace-switch:2";
            "Mod+3" = "workspace-switch:3";
            "Mod+4" = "workspace-switch:4";
            "Mod+5" = "workspace-switch:5";
            "Mod+6" = "workspace-switch:6";
            "Mod+7" = "workspace-switch:7";
            "Mod+8" = "workspace-switch:8";
            "Mod+9" = "workspace-switch:9";
            "Mod+KP_End" = "workspace-switch:1";
            "Mod+KP_Down" = "workspace-switch:2";
            "Mod+KP_Next" = "workspace-switch:3";
            "Mod+KP_Left" = "workspace-switch:4";
            "Mod+KP_Begin" = "workspace-switch:5";
            "Mod+KP_Right" = "workspace-switch:6";
            "Mod+KP_Home" = "workspace-switch:7";
            "Mod+KP_Up" = "workspace-switch:8";
            "Mod+KP_Prior" = "workspace-switch:9";
            "Mod+Prior" = "workspace-previous";
            "Mod+Next" = "workspace-next";
            "Mod+KP_Subtract" = "workspace-previous";
            "Mod+KP_Add" = "workspace-next";
            "Mod+WheelUp" = "workspace-previous";
            "Mod+WheelDown" = "workspace-next";
            "Mod+Shift+1" = "window-move-to-workspace:1";
            "Mod+Shift+2" = "window-move-to-workspace:2";
            "Mod+Shift+3" = "window-move-to-workspace:3";
            "Mod+Shift+4" = "window-move-to-workspace:4";
            "Mod+Shift+5" = "window-move-to-workspace:5";
            "Mod+Shift+6" = "window-move-to-workspace:6";
            "Mod+Shift+7" = "window-move-to-workspace:7";
            "Mod+Shift+8" = "window-move-to-workspace:8";
            "Mod+Shift+9" = "window-move-to-workspace:9";
            "Mod+Shift+KP_End" = "window-move-to-workspace:1";
            "Mod+Shift+KP_Down" = "window-move-to-workspace:2";
            "Mod+Shift+KP_Next" = "window-move-to-workspace:3";
            "Mod+Shift+KP_Left" = "window-move-to-workspace:4";
            "Mod+Shift+KP_Begin" = "window-move-to-workspace:5";
            "Mod+Shift+KP_Right" = "window-move-to-workspace:6";
            "Mod+Shift+KP_Home" = "window-move-to-workspace:7";
            "Mod+Shift+KP_Up" = "window-move-to-workspace:8";
            "Mod+Shift+KP_Prior" = "window-move-to-workspace:9";
            "Mod+Shift+Prior" = "workspace-move-up";
            "Mod+Shift+Next" = "workspace-move-down";
            "Mod+Shift+KP_Subtract" = "workspace-move-up";
            "Mod+Shift+KP_Add" = "workspace-move-down";
            "Mod+D" = "workspace-switch:64";

            "Mod+M" = "workspace-set-layout:toggle";

            # Scratchpads
            "Mod+Shift+Y" = "scratchpad-toggle:minimized";
            "Mod+Y" = "window-toggle-scratchpad:minimized";
          };

          appearance = {
            border_width = 2;
          };

          window_rule = [
            {
              match.is_floating = true;
              match.is_focused = false;
              match.is_pinned = false;
              opacity = 0.7;
            }
            {
              match.is_pinned = true;
              border_width = ceil (config.programs.umbriel.settings.appearance.border_width * 1.5);
            }

            {
              match.title = "(A|a)lert";
              default_floating = true;
            }
            {
              match.title = "(S|s)etup";
              default_floating = true;
            }
            {
              match.title = "(P|p)rogress";
              default_floating = true;
            }
          ];
        };
      };
      xdg.configFile = flake.lib.mkMutableFiles [ "umbriel/config.toml" ];

      xdg.portal.configPackages = mkIf (config.programs.umbriel.package != null) [
        config.programs.umbriel.package
      ];
    }

    (mkIf cfg.ttyAutostart {
      programs.bash.profileExtra = ''
        if [[ $(tty) =~ /dev/tty[${cfg.ttyAutostartNumbers}] ]]; then
          exec start-umbriel
        fi
      '';
      programs.fish.loginShellInit = ''
        if string match --regex --quiet "/dev/tty[${cfg.ttyAutostartNumbers}]" $(tty)
          exec start-umbriel
        end
      '';
    })
  ];
}
