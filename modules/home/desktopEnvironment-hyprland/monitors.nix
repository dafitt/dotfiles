{ config, lib, ... }:
with lib;
let
  cfg = config.dafitt.desktopEnvironment-hyprland;
in
{
  options.dafitt.desktopEnvironment-hyprland = with types; {
    monitors = mkOption {
      type = listOf (submodule {
        options = {
          enable = mkOption {
            type = bool;
            description = "Can be switched off here.";
            default = true;
            example = false;
          };
          name = mkOption {
            type = str;
            description = "Get the name with `hyprctl monitors all` or `wlr-randr`.";
            example = "desc:Microstep MSI MAG271CQP 0x3030424C";
          };
          primary = mkOption {
            type = bool;
            description = "Define one primary monitor.";
            default = false;
          };
          width = mkOption {
            type = addCheck int (n: n >= 0);
            example = 1920;
          };
          height = mkOption {
            type = addCheck int (n: n >= 0);
            example = 1080;
          };
          refreshRate = mkOption {
            type = addCheck int (n: n >= 0);
            example = 144;
            default = 60;
          };
          x = mkOption {
            type = int;
            description = "The x-coordinate of the monitor.";
            default = 0;
          };
          y = mkOption {
            type = int;
            description = "The y-coordinate of the monitor.";
            default = 0;
          };
          scale = mkOption {
            type = addCheck float (n: n > 0);
            example = 1.25;
            description = "The scale of the monitor.";
            default = 1.0;
          };
          transform = mkOption {
            type = addCheck int (n: n >= 0 && n <= 7);
            description = ''
              Controls the transformation of your monitors.
              0 - normal (no transforms)
              1 - 90 degrees
              2 - 180 degrees
              3 - 270 degrees
              4 - flipped
              5 - flipped + 90 degrees
              6 - flipped + 180 degrees
              7 - flipped + 270 degrees
            '';
            default = 0;
          };
          vrr = mkOption {
            type = addCheck int (n: n >= 0 && n <= 2);
            description = ''
              Controls the VRR (Adaptive Sync) of your monitors.
              0 - off
              1 - on
              2 - fullscreen only
            '';
            default = 0;
          };
          bitdepth = mkOption {
            type = enum [
              8
              10
            ];
            description = ''
              The bit depth of the monitor. Can be either 8 or 10.
              NOTE: Colors registered in Hyprland (e.g. the border color) do not support 10 bit.
              NOTE: Some applications do not support screen capture with 10 bit enabled.
            '';
            default = 8;
          };
          mirror = mkOption {
            type = nullOr str;
            description = "Mirror a monitor.";
            default = null;
            example = "DP-1";
          };
          workspace = mkOption {
            type = nullOr str;
            description = "The workspace assigned to the monitor.";
            default = null;
          };
        };
      });
      default = [ ];
      description = "Declarative configuration for your hyprland monitors.";
      example = [
        {
          name = "DP-0";
          primary = true;
          width = 2560;
          height = 1440;
          refreshRate = 144;
        }
        {
          name = "DP-1";
          primary = false;
          width = 1920;
          height = 1080;
          refreshRate = 120;
          vrr = 1;
          bitdepth = 10;
          x = 2560;
          y = 0;
          transform = 0;
          mirror = null;
          workspace = "8";
        }
      ];
    };
  };

  config = {
    assertions = [
      {
        assertion =
          ((lib.length cfg.monitors) != 0) -> ((lib.length (lib.filter (m: m.primary) cfg.monitors)) == 1);
        message = "Exactly one monitor must be set to primary.";
      }
      {
        assertion = lib.all (monitor: !(monitor.primary && monitor.mirror != null)) cfg.monitors;
        message = "The primary monitor cannot be a mirror.";
      }
    ];

    wayland.windowManager.hyprland.settings.monitor =
      # https://wiki.hypr.land/Configuring/Monitors/
      # https://wiki.hypr.land/hyprland-wiki/pages/Configuring/Advanced-config/#monitors

      #$ nix run nixpkgs#wlr-randr

      # monitor=name,resolution{preferred,highres,highrr,disable},position,scale
      # ,transform,1
      # ,mirror,<NAME>
      # ,bitdepth,10
      # ,vrr,<0>
      map (
        m:
        let
          resolution = "${toString m.width}x${toString m.height}@${toString m.refreshRate}";
          position = "${toString m.x}x${toString m.y}";
          scale = ",${toString m.scale}";
          transform = if m.transform != 0 then ",transform,${toString m.transform}" else "";
          vrr = if m.vrr != 0 then ",vrr,${toString m.vrr}" else "";
          bitdepth = if m.bitdepth != 8 then ",bitdepth,${toString m.bitdepth}" else "";
          mirror = if m.mirror != null then ",mirror,${m.mirror}" else "";
        in
        "${m.name},${
          if m.enable then
            "${resolution},${position}${scale}${transform}${vrr}${bitdepth}${mirror}"
          else
            "disable"
        }"
      ) (cfg.monitors);
  };
}
