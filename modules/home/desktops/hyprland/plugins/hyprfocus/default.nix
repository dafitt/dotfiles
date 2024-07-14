{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.desktops.hyprland.plugins.hyprfocus;
  hyprlandCfg = config.wayland.windowManager.hyprland;
in
{
  options.dafitt.desktops.hyprland.plugins.hyprfocus = with types;
    {
      enable = mkBoolOpt false "Enable the hyprfocus hyprland plugin.";
    };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      # https://github.com/pyt0xic/hyprfocus
      plugins = [ pkgs.hyprlandPlugins.hyprfocus ];

      settings = {
        # borderless experience:
        general.border_size = mkForce 0;
        decoration.dim_inactive = mkForce false;
        decoration.drop_shadow = mkForce false;
      };

      extraConfig = ''
        plugin:hyprfocus {
          enabled = yes
          focus_animation = flash
          animate_floating = yes
          animate_workspacechange = no
          # Beziers for focus animations
          bezier = bezIn, 0.5,0.0,1.0,0.5
          bezier = bezOut, 0.0,0.5,0.5,1.0
          bezier = overshot, 0.05, 0.9, 0.1, 1.05
          bezier = smoothOut, 0.36, 0, 0.66, -0.56
          bezier = smoothIn, 0.25, 1, 0.5, 1
          bezier = realsmooth, 0.28,0.29,.69,1.08
          # Flash settings
          flash {
            flash_opacity = ${toString (hyprlandCfg.settings.decoration.active_opacity * 0.9)}
            in_bezier = realsmooth
            in_speed = 0.5
            out_bezier = realsmooth
            out_speed = 3
          }
          # Shrink settings
          shrink {
            shrink_percentage = 0.95
            in_bezier = realsmooth
            in_speed = 1
            out_bezier = realsmooth
            out_speed = 2
          }
        }
      '';
    };
  };
}
