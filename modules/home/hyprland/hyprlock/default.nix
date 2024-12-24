{ options, config, lib, pkgs, inputs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.hyprland.hyprlock;
  hyprlandCfg = config.wayland.windowManager.hyprland;
in
{
  options.dafitt.hyprland.hyprlock = with types; {
    enable = mkBoolOpt config.dafitt.hyprland.enable "Whether to enable screenlocking.";
  };

  config = mkIf cfg.enable {
    home.packages = [ config.programs.hyprlock.package ];

    # https://wiki.hyprland.org/Hypr-Ecosystem/hyprlock/
    programs.hyprlock = {
      enable = true;

      settings = {
        general = {
          grace = 5;
          no_fade_in = true;
        };
      };

      extraConfig = ''
        background {
          monitor =
          path = ${config.stylix.image}
          blur_passes = 2
        }

        input-field {
          monitor =
          size = 200, 50
          outline_thickness = ${toString hyprlandCfg.settings.general.border_size}
          dots_size = 0.33 # Scale of input-field height, 0.2 - 0.8
          dots_spacing = 0.15 # Scale of dots' absolute size, 0.0 - 1.0
          dots_center = true
          dots_rounding = -1 # -1 default circle, -2 follow input-field rounding
          outer_color = rgb(${config.lib.stylix.colors.base0A})
          inner_color = rgb(${config.lib.stylix.colors.base03})
          font_color = rgb(${config.lib.stylix.colors.base05})
          fade_on_empty = true
          fade_timeout = 1000 # Milliseconds before fade_on_empty is triggered.
          placeholder_text = <i>Input Password...</i> # Text rendered in the input box when it's empty.
          hide_input = false
          rounding = -1 # -1 means complete rounding (circle/oval)
          check_color = rgb(${config.lib.stylix.colors.base0B})
          fail_color = rgb(${config.lib.stylix.colors.base08})
          fail_text = <i>$FAIL <b>($ATTEMPTS)</b></i> # can be set to empty
          fail_transition = 300 # transition time in ms between normal outer_color and fail_color
          capslock_color = rgb(${config.lib.stylix.colors.base09})
          numlock_color = -1
          bothlock_color = -1 # when both locks are active. -1 means don't change outer color (same for above)
          invert_numlock = false # change color if numlock is off
          swap_font_color = false # see below

          position = 0, -20
          halign = center
          valign = center
        }

        label {
          text = $TIME
          text_align = center
          color = rgb(${config.lib.stylix.colors.base05})
          font_size = 44
          font_family = ${config.stylix.fonts.monospace.name}
          rotate = 0

          position = 0, 80
          halign = center
          valign = center
        }
        label {
          text = Welcome back!
          text_align = center
          color = rgb(${config.lib.stylix.colors.base04})
          font_size = 20
          font_family = ${config.stylix.fonts.monospace.name}
          rotate = 0

          position = 0, -30
          halign = center
          valign = top
        }
      '';
    };

    wayland.windowManager.hyprland.settings.bind = [
      "SUPER, L, exec, ${getExe config.programs.hyprlock.package}" # Lock the screen
    ];
  };
}
