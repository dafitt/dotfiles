{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.desktops.hyprland.waybar;
in
{
  options.dafitt.desktops.hyprland.waybar = with types; {
    enable = mkBoolOpt config.dafitt.desktops.hyprland.enable;
  };

  config = {
    dafitt.desktops.hyprland.swayosd.enable = true;

    programs.waybar = {
      enable = true;
      systemd = {
        enable = true;
        target = "hyprland-session.target";
      };

      # https://github.com/Alexays/Waybar/wiki/Configuration
      settings = [{

        #TODO primary monitor only ``` (lib.find (monitor: monitor.primary)  config.wayland.windowManager.hyprland.monitors;).name

        layer = "top";
        position = "bottom";

        # modules left
        modules-left = [ "custom/l" "custom/launcher" "custom/_" "hyprland/workspaces" "custom/r" "custom/l" "wlr/taskbar" "hyprland/window" "custom/r" ];
        "custom/launcher" = {
          format = " ";
          on-click = "pkill fuzzel || ${pkgs.fuzzel}/bin/fuzzel";
          tooltip = false;
        };
        "wlr/taskbar" = {
          format = "{icon}";
          icon-size = 18;
          icon-theme = config.gtk.iconTheme.name;
          tooltip-format = "{title}";
          on-click = "activate";
          on-click-middle = "close";
          ignore-list = [ ];
          app_ids-mapping = {
            firefoxdeveloperedition = "firefox-developer-edition";
          };
        };
        "hyprland/window" = { "format" = "{class}"; };

        # modules mid
        modules-center = [ "custom/l" "clock" "custom/r" ];
        "clock" = {
          format = "{:%R  %Y·%m·%d}";
          format-alt = "{:%R} ";
          tooltip-format = "<tt>{calendar}</tt>";
          calendar = {
            mode = "month";
            mode-mon-col = 3;
            on-scroll = 1;
            on-click-right = "mode";
            format = {
              months = "<span color = '#ffead3'><b>{}</b></span>";
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

        # modules right
        modules-right = [ "custom/l" "tray" "custom/r" "custom/l" "backlight" "bluetooth" "network" "battery" "custom/_" "pulseaudio#microphone" "pulseaudio" "custom/r" ];
        "tray" = {
          icon-size = 18;
          spacing = 5;
        };
        "backlight" = {
          device = "intel_backlight";
          format = "{icon} {percent}%";
          format-icons = [ "" "" "" "" "" "" "" "" "" ];
          on-scroll-up = "brightnessctl set 1%+";
          on-scroll-down = "brightnessctl set 1%-";
          min-length = 6;
        };
        "bluetooth" = {
          format = "";
          format-disabled = "";
          # an empty format will hide the module
          format-connected = " {num_connections}";
          tooltip-format = " {device_alias}";
          tooltip-format-connected = "{device_enumerate}";
          tooltip-format-enumerate-connected = " {device_alias}";
        };
        "network" = {
          #interface = "wlp2*"; # (Optional) To force the use of this interface
          format-wifi = "󰤨 {essid}";
          format-ethernet = "󱘖 Wired";
          tooltip-format = "󱘖 {ipaddr}  {bandwidthDownBytes}  {bandwidthUpBytes}";
          format-linked = "󱘖 {ifname} (No IP)";
          format-disconnected = " Disconnected";
          format-alt = "󰤨 {signalStrength}%";
          interval = 5;
        };
        "pulseaudio#microphone" = {
          format = "{format_source}";
          format-source = "";
          format-source-muted = "";
          on-click = "pavucontrol -t 4";
          on-click-middle = "${config.services.swayosd.package}/bin/swayosd --input-volume mute-toggle";
          on-scroll-up = "${config.services.swayosd.package}/bin/swayosd --input-volume raise";
          on-scroll-down = "${config.services.swayosd.package}/bin/swayosd --input-volume lower";
          tooltip-format = "{format_source} {source_desc} // {source_volume}%";
          scroll-step = 5;
        };
        "pulseaudio" = {
          format = "{icon} {volume}";
          format-muted = "";
          on-click = "pavucontrol -t 3";
          on-click-middle = "${config.services.swayosd.package}/bin/swayosd --output-volume mute-toggle";
          on-scroll-up = "${config.services.swayosd.package}/bin/swayosd --output-volume raise";
          on-scroll-down = "${config.services.swayosd.package}/bin/swayosd --output-volume lower";
          tooltip-format = "{icon} {desc} // {volume}%";
          scroll-step = 5;
          format-icons = { headphone = ""; hands-free = ""; headset = ""; phone = ""; portable = ""; car = ""; default = [ "" "" "" ]; };
        };
        "battery" = {
          states = {
            good = 75;
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-plugged = " {capacity}%";
          format-alt = "{icon} {time}";
          format-icons = [ "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
        };

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
  };
}
