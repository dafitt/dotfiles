{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.hyprland.hyprlock;
  hyprlandCfg = config.wayland.windowManager.hyprland;
in
{
  options.dafitt.hyprland.hyprlock = with types; {
    enable = mkEnableOption "hyprlock, screenlocking";
  };

  config = mkIf cfg.enable {
    dafitt.stylix.enable = true;

    home.packages = [ config.programs.hyprlock.package ];

    # https://wiki.hypr.land/Hypr-Ecosystem/hyprlock/
    programs.hyprlock = {
      enable = true;

      settings = {
        general = {
          grace = 3;
        };
        background = {
          path = mkForce "screenshot";
          blur_passes = 3;
          blur_size = 16;
        };
        bezier = config.wayland.windowManager.hyprland.settings.animations.bezier;
        animation = lib.elemAt config.wayland.windowManager.hyprland.settings.animations.animation 0;
        input-field = {
          outline_thickness = toString hyprlandCfg.settings.general.border_size;
          capslock_color = "rgb(${config.lib.stylix.colors.base0E})";
        };
      };

      extraConfig = ''
        label {
          text = $TIME
          text_align = center
          rotate = 0
          position = 0, 160
          halign = center
          valign = center
          font_size = 80
          font_family = ${config.stylix.fonts.monospace.name}
          color = rgb(${config.lib.stylix.colors.base05})
        }
        label {
          text = Time for a break!
          text_align = center
          rotate = 0
          position = 0, -30
          halign = center
          valign = top
          font_size = 20
          font_family = ${config.stylix.fonts.monospace.name}
          color = rgb(${config.lib.stylix.colors.base04})
        }
      '';
    };

    wayland.windowManager.hyprland.settings.bind = [
      "SUPER, L, exec, uwsm app -- ${getExe config.programs.hyprlock.package}" # Lock the screen
    ];
  };
}
