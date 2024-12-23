{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.desktops.hyprland.plugins.hypr-dynamic-cursors;
in
{
  options.dafitt.desktops.hyprland.plugins.hypr-dynamic-cursors = with types; {
    enable = mkBoolOpt false "Whether to enable the hypr-dynamic-cursors hyprland plugin.";
  };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      # https://github.com/VirtCode/hypr-dynamic-cursors
      plugins = [ pkgs.hyprlandPlugins.hypr-dynamic-cursors ];

      extraConfig = ''
        plugin:dynamic-cursors {
          enabled = true

          # sets the cursor behaviour, supports these values:
          # tilt   - tilt the cursor based on x-velocity
          # rotate - rotate the cursor based on movement direction
          # stretch - stretch the cursor shape based on direction and velocity
          # none   - do not change the cursors behaviour
          mode = rotate

          # minimum angle difference in degrees after which the shape is changed
          # smaller values are smoother, but more expensive for hw cursors
          threshold = 2

          # override the mode behaviour per shape
          # this is a keyword and can be repeated many times
          # by default, there are no rules added
          # see the dedicated `shape rules` section below!
          #shaperule = <shape-name>, <mode> (optional), <property>: <value>, ...
          #shaperule = <shape-name>, <mode> (optional), <property>: <value>, ...
          #...

          # for mode = rotate
          rotate {

            # length in px of the simulated stick used to rotate the cursor
            # most realistic if this is your actual cursor size
            length = 20

            # clockwise offset applied to the angle in degrees
            # this will apply to ALL shapes
            offset = 0.0
          }

          # for mode = tilt
          tilt {

            # controls how powerful the tilt is, the lower the more power
            # this value controls at which speed (px/s) the full tilt is reached
            limit = 5000

            # relationship between speed and tilt, supports these vaules:
            # linear             - a linear function is used
            # quadratic          - a quadratic function is used (most realistic to actual air drag)
            # negative_quadratic - negative version of the quadratic one, feels more aggressive
            function = negative_quadratic
          }

          # for mode = stretch
          stretch {

            # controls how much the cursor is stretched
            # this value controls at which speed (px/s) the full stretch is reached
            limit = 3000

            # relationship between speed and stretch amount, supports these vaules:
            # linear             - a linear function is used
            # quadratic          - a quadratic function is used
            # negative_quadratic - negative version of the quadratic one, feels more aggressive
            function = quadratic
          }

          # configure shake to find
          # magnifies the cursor if its is being shaken
          shake {

            # enables shake to find
            enabled = true

            # controls how soon a shake is detected
            # lower values mean sooner
            threshold = 4.0

            # controls how fast the cursor gets larger
            factor = 1.5

            # show cursor behaviour `tilt`, `rotate`, etc. while shaking
            effects = true

            # use nearest-neighbour (pixelated) scaling when shaking
            # may look weird when effects are enabled
            nearest = true

            # enable ipc events for shake
            # see #3
            ipc = false
          }
        }
      '';
    };
  };
}
