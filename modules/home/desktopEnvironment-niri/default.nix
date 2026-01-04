{
  lib,
  pkgs,
  inputs,
  perSystem,
  ...
}:
with lib;
{
  imports = with inputs; [
    niri.homeModules.niri
    self.homeModules.noctalia
    ../desktopEnvironment-common/keybinds.nix
  ];

  home.packages = with pkgs; [
    wdisplays
    xwayland-satellite
  ];

  programs.niri = {
    enable = true;
    package = pkgs.niri; # follow nixpkgs

    # https://yalter.github.io/niri/Configuration%3A-Introduction.html
    # https://github.com/sodiboo/niri-flake/blob/main/docs.md
    settings = {

      prefer-no-csd = true;

      layout = {
        gaps = 8;

        center-focused-column = "never";

        preset-column-widths = [
          { proportion = 1. / 3.; }
          { proportion = 0.5; }
          { proportion = 2. / 3.; }
        ];
        preset-window-heights = [
          { proportion = 0.5; }
          { proportion = 1.0; }
        ];

        default-column-width = {
          proportion = 1. / 3.;
        };

        focus-ring = {
          enable = true;
          width = 2;
        };

        shadow = {
          enable = true;
        };
      };

      input = {
        focus-follows-mouse = {
          enable = true;
          max-scroll-amount = "10%";
        };
        workspace-auto-back-and-forth = true;
      };

      hotkey-overlay.skip-at-startup = true;

      binds = {
        #$ niri msg action [<action> --help]

        "Mod+Ssharp".action.show-hotkey-overlay = { };

        "Mod+Control+Q".action.quit.skip-confirmation = true;
        # "Mod+Control+R".action.load-config-file = { };
        "Mod+Odiaeresis".action.power-off-monitors = { };

        "Mod+X" = {
          repeat = false;
          action.close-window = { };
        };
        "Mod+F".action.fullscreen-window = { };
        "Mod+A".action.maximize-column = { };
        "Mod+V".action.toggle-window-floating = { };
        "Mod+C".action.center-column = { };
        "Mod+Shift+C".action.center-visible-columns = { };
        "Mod+R".action.switch-preset-column-width = { };
        "Mod+Shift+R".action.switch-preset-window-height = { };
        "Mod+O" = {
          repeat = false;
          action.toggle-overview = { };
        };
        "Mod+Asciicircum" = {
          repeat = false;
          action.toggle-overview = { };
        };

        "Mod+Left".action.focus-column-or-monitor-left = { };
        "Mod+Right".action.focus-column-or-monitor-right = { };
        "Mod+Up".action.focus-window-or-workspace-up = { };
        "Mod+Down".action.focus-window-or-workspace-down = { };
        "Mod+Shift+Left".action.move-column-left-or-to-monitor-left = { };
        "Mod+Shift+Right".action.move-column-right-or-to-monitor-right = { };
        "Mod+Shift+Up".action.move-window-up-or-to-workspace-up = { };
        "Mod+Shift+Down".action.move-window-down-or-to-workspace-down = { };

        "Alt+Tab".action.focus-window-previous = { };

        "Mod+Home".action.focus-column-first = { };
        "Mod+End".action.focus-column-last = { };
        "Mod+Shift+Home".action.move-column-to-first = { };
        "Mod+Shift+End".action.move-column-to-last = { };

        "Mod+Plus".action.set-column-width = "+10%";
        "Mod+Minus".action.set-column-width = "-10%";
        "Mod+Shift+Plus".action.set-window-height = "+10%";
        "Mod+Shift+Minus".action.set-window-height = "-10%";
        "Mod+Alt+Right".action.set-column-width = "+10%";
        "Mod+Alt+Left".action.set-column-width = "-10%";
        "Mod+Alt+Up".action.set-window-height = "-10%";
        "Mod+Alt+Down".action.set-window-height = "+10%";

        "Mod+T".action.toggle-column-tabbed-display = { };
        "Mod+Comma".action.consume-or-expel-window-left = { };
        "Mod+Period".action.consume-or-expel-window-right = { };
        "Mod+BracketLeft".action.consume-or-expel-window-left = { };
        "Mod+BracketRight".action.consume-or-expel-window-right = { };

        "Mod+WheelScrollDown" = {
          cooldown-ms = 150;
          action.focus-workspace-down = { };
        };
        "Mod+WheelScrollUp" = {
          cooldown-ms = 150;
          action.focus-workspace-up = { };
        };
        "Mod+Alt+WheelScrollDown" = {
          cooldown-ms = 150;
          action.move-column-to-workspace-down = { };
        };
        "Mod+Alt+WheelScrollUp" = {
          cooldown-ms = 150;
          action.move-column-to-workspace-up = { };
        };

        "Mod+Shift+WheelScrollDown" = {
          cooldown-ms = 150;
          action.focus-column-right = { };
        };
        "Mod+Shift+WheelScrollUp" = {
          cooldown-ms = 150;
          action.focus-column-left = { };
        };
        "Mod+Shift+Alt+WheelScrollDown" = {
          cooldown-ms = 150;
          action.move-column-right = { };
        };
        "Mod+Shift+Alt+WheelScrollUp" = {
          cooldown-ms = 150;
          action.move-column-left = { };
        };
        "Mod+WheelScrollRight".action.focus-column-right = { };
        "Mod+WheelScrollLeft".action.focus-column-left = { };
        "Mod+Shift+WheelScrollRight".action.move-column-right = { };
        "Mod+Shift+WheelScrollLeft".action.move-column-left = { };

        "Mod+1".action.focus-workspace = 1;
        "Mod+2".action.focus-workspace = 2;
        "Mod+3".action.focus-workspace = 3;
        "Mod+4".action.focus-workspace = 4;
        "Mod+5".action.focus-workspace = 5;
        "Mod+6".action.focus-workspace = 6;
        "Mod+7".action.focus-workspace = 7;
        "Mod+8".action.focus-workspace = 8;
        "Mod+9".action.focus-workspace = 9;
        "Mod+Shift+1".action.move-column-to-workspace = 1;
        "Mod+Shift+2".action.move-column-to-workspace = 2;
        "Mod+Shift+3".action.move-column-to-workspace = 3;
        "Mod+Shift+4".action.move-column-to-workspace = 4;
        "Mod+Shift+5".action.move-column-to-workspace = 5;
        "Mod+Shift+6".action.move-column-to-workspace = 6;
        "Mod+Shift+7".action.move-column-to-workspace = 7;
        "Mod+Shift+8".action.move-column-to-workspace = 8;
        "Mod+Shift+9".action.move-column-to-workspace = 9;
        "Mod+Tab".action.focus-workspace-previous = { };

        "Mod+Page_Down".action.focus-workspace-down = { };
        "Mod+Page_Up".action.focus-workspace-up = { };
        "Mod+U".action.focus-workspace-down = { };
        "Mod+I".action.focus-workspace-up = { };
        "Mod+Shift+Page_Down".action.move-workspace-down = { };
        "Mod+Shift+Page_Up".action.move-workspace-up = { };
        "Mod+Shift+U".action.move-workspace-down = { };
        "Mod+Shift+I".action.move-workspace-up = { };

        # Screenshot
        "Print".action.screenshot = { };
        "Control+Print".action.screenshot-screen = { };
        "Alt+Print".action.screenshot-window = { };
      };

      screenshot-path = "~/Pictures/Screenshots/%Y-%m-%dT%H:%M:%S.png";

      input.keyboard.numlock = true;

      window-rules = [
        {
          geometry-corner-radius = {
            top-left = 12.0;
            top-right = 12.0;
            bottom-left = 12.0;
            bottom-right = 12.0;
          };
          clip-to-geometry = true;
          # open-maximized-to-edges = false; # TODO: after https://github.com/sodiboo/niri-flake/pull/1548
        }
      ];

      spawn-at-startup = [
        { argv = [ (getExe perSystem.niri-system76-scheduler.default) ]; }
      ];
    };
  };
}
