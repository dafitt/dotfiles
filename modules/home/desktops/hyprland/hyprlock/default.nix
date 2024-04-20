{ options, config, lib, pkgs, inputs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.desktops.hyprland.hyprlock;
  hyprlandCfg = config.wayland.windowManager.hyprland;
in
{
  options.dafitt.desktops.hyprland.hyprlock = with types; {
    enable = mkBoolOpt config.dafitt.desktops.hyprland.enable "Enable screenlocking";
    package = mkOpt' package inputs.hyprlock.packages.${pkgs.system}.default;
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];

    # https://github.com/hyprwm/hyprlock/blob/main/nix/hm-module.nix
    programs.hyprlock = {
      enable = true;
      package = cfg.package;

      general = {
        grace = 2;
        hide_cursor = false;
      };

      backgrounds = [{
        path = "${config.stylix.image}";
        blur_passes = 2;
      }];

      input-fields = [{
        outline_thickness = hyprlandCfg.settings.general.border_size;
        outer_color = "rgb(${config.lib.stylix.colors.base0A})";
        inner_color = "rgb(${config.lib.stylix.colors.base03})";
        font_color = "rgb(${config.lib.stylix.colors.base05})";
        check_color = "rgb(${config.lib.stylix.colors.base0B})";
        fail_color = "rgb(${config.lib.stylix.colors.base08})";
        capslock_color = "rgb(${config.lib.stylix.colors.base09})";
      }];

      labels = [
        {
          text = "$TIME";
          color = "rgb(${config.lib.stylix.colors.base05})";
          font_family = "${config.stylix.fonts.monospace.name}";
          font_size = 44;
        }
        {
          text = "Welcome back, $USER!";
          color = "rgb(${config.lib.stylix.colors.base04})";
          font_family = "${config.stylix.fonts.monospace.name}";
          font_size = 20;
          valign = "top";
          position.y = -30;
        }
      ];
    };

    wayland.windowManager.hyprland.settings.bind = [
      "SUPER, L, exec, ${getExe cfg.package}" # Lock the screen
    ];
  };
}
