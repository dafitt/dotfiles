{ options, config, lib, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.desktops.hyprland;
in
{
  options.custom.desktops.hyprland = with types; {
    monitors = mkOption {
      type = listOf (submodule {
        options = {
          enable = mkOption {
            type = bool;
            default = true;
            example = false;
            description = "Can be switched off here.";
          };
          name = mkOption {
            type = str;
            example = "DP-1";
            description = "Get the name with 'wlr-randr'";
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
            default = 60;
            example = 144;
          };
          vrr = mkOption {
            type = addCheck int (n: n >= 0 && n <= 2);
            default = 0;
            description = ''
              Controls the VRR (Adaptive Sync) of your monitors.
              0 - off
              1 - on
              2 - fullscreen only
            '';
          };
          bitdepth = mkOption {
            type = enum [ 8 10 ];
            default = 8;
            description = ''
              The bit depth of the monitor. Can be either 8 or 10.
              NOTE: Colors registered in Hyprland (e.g. the border color) do not support 10 bit.
              NOTE: Some applications do not support screen capture with 10 bit enabled.
            '';
          };
          x = mkOption {
            type = int;
            default = 0;
            description = "The x-coordinate of the monitor.";
          };
          y = mkOption {
            type = int;
            default = 0;
            description = "The y-coordinate of the monitor.";
          };
          transform = mkOption {
            type = addCheck int (n: n >= 0 && n <= 7);
            default = 0;
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
          };
          primary = mkOption {
            type = bool;
            default = false;
            description = "Define one primary monitor.";
          };
          mirror = mkOption {
            type = nullOr str;
            default = null;
            description = "Mirror a monitor. e.g. 'DP-1'";
          };
          workspace = mkOption {
            type = nullOr str;
            default = null;
            description = "The workspace assigned to the monitor.";
          };
        };
      });
      default = [ ];
    };
  };

  config = {
    assertions = [
      {
        assertion = ((lib.length cfg.monitors) != 0) -> ((lib.length (lib.filter (m: m.primary) cfg.monitors)) == 1);
        message = "Exactly one monitor must be set to primary.";
      }
      {
        assertion = lib.all (monitor: !(monitor.primary && monitor.mirror != null)) cfg.monitors;
        message = "The primary monitor cannot be a mirror.";
      }
    ];

    wayland.windowManager.hyprland.settings.monitor =
      # https://wiki.hyprland.org/Configuring/Monitors/
      # https://wiki.hyprland.org/hyprland-wiki/pages/Configuring/Advanced-config/#monitors

      #$ nix run nixpkgs#wlr-randr

      # monitor=name,resolution{preferred,highres,highrr,disable},position,scale
      # ,transform,1
      # ,mirror,[NAME]
      # ,bitdepth,10
      # ,vrr,[0]
      map
        (m:
          let
            resolution = "${toString m.width}x${toString m.height}@${toString m.refreshRate}";
            position = "${toString m.x}x${toString m.y}";
            vrr = if m.vrr != 0 then ",vrr,${toString m.vrr}" else "";
            bitdepth = if m.bitdepth != 8 then ",bitdepth,${toString m.bitdepth}" else "";
            transform = if m.transform != 0 then ",transform,${toString m.transform}" else "";
            mirror = if m.mirror != null then ",mirror,${m.mirror}" else "";
          in
          "${m.name},${if m.enable then
            "${resolution},${position},1${transform}${vrr}${bitdepth}${mirror}"
          else "disable"}"
        )
        (cfg.monitors);
  };
}
