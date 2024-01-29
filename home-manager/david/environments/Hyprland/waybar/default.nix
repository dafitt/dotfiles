{ config, lib, pkgs, ... }: {
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      target = "hyprland-session.target";
    };

    settings = [{

      # TODO primary monitor only ``` (lib.find (monitor: monitor.primary)  config.wayland.windowManager.hyprland.monitors;).name

      layer = "top"; # Waybar at top layer
      position = "bottom"; # Waybar position (top|bottom|left|right)
      #height = 30; # Waybar height (to be removed for auto height)
      #width = 1280; # Waybar width
      #spacing = 4; # Gaps between modules (4px)

      modules-left = [ "custom/l" "custom/launcher" "hyprland/workspaces" "custom/r" ];
      "custom/launcher" = {
        "format" = " ";
        "tooltip" = false;
      };
      "hyprland/workspaces" = { };

      modules-center = [ "custom/l" "clock" "custom/r" ];
      "clock" = {
        format = "{:%R}";
        format-alt = "{:%R 󰃭 %Y·%m·%d}";
        tooltip-format = "<tt>{calendar}</tt>";
        calendar = {
          mode = "month";
          mode-mon-col = 3;
          on-scroll = 1;
          on-click-right = "mode";
          format = {
            months = "<span color='#ffead3'><b>{}</b></span>";
            weekdays = "<span color='#ffcc66'><b>{}</b></span>";
            today = "<span color='#ff6699'><b>{}</b></span>";
          };
        };
        actions = {
          on-click-right = "mode";
          on-click-forward = "tz_up";
          on-click-backward = "tz_down";
          on-scroll-up = "shift_up";
          on-scroll-down = "shift_down";
        };
      };

      modules-right = [ ];

      # modules for padding #
      "custom/l" = { format = " "; interval = "once"; tooltip = false; };
      "custom/r" = { format = " "; interval = "once"; tooltip = false; };
      "custom/sl" = { format = " "; interval = "once"; tooltip = false; };
      "custom/sr" = { format = " "; interval = "once"; tooltip = false; };
      "custom/rl" = { format = " "; interval = "once"; tooltip = false; };
      "custom/rr" = { format = " "; interval = "once"; tooltip = false; };
      "custom/_" = { format = " "; interval = "once"; tooltip = false; };
      "custom/__" = { format = "  "; interval = "once"; tooltip = false; };
    }];

    # Gets merged with Stylix' config
    style = ''
      * {
        font-family: "${config.stylix.fonts.monospace.name}";
        font-weight: bold;
        border-bottom: none;
      }
    '' + (builtins.readFile ./modules.css);
  };

  # toggle waybar
  wayland.windowManager.hyprland.settings.bind = [ "SUPER, W, exec, ${pkgs.killall}/bin/killall -SIGUSR1 .waybar-wrapped" ];
}
