{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib;
let
  cfg = config.dafitt.desktopEnvironment-hyprland.plugins.hyprspace;
in
{
  imports = with inputs; [
    self.homeModules.stylix
  ];

  options.dafitt.desktopEnvironment-hyprland.plugins.hyprspace = {
    enable = mkEnableOption "hyprspace";
  };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      # https://github.com/KZDKM/Hyprspace
      plugins = [ pkgs.hyprlandPlugins.hyprspace ];

      settings.bind = [
        {
          _args = [
            "SUPER + Asciicircum"
            (mkLuaInline ''hl.plugin.Hyprspace.overview("toggle")'')
            { description = "Open/close overview"; }
          ];
        }
      ];

      # https://github.com/KZDKM/Hyprspace?tab=readme-ov-file#configuration
      settings.config.plugin.overview = {
        # behaviour
        exit_on_switch = true;

        # theming
        draw_active_workspace = false;
        panel_border_color = "rgb(${config.lib.stylix.colors.base0C})";
        panel_border_width = config.wayland.windowManager.hyprland.settings.config.general.border_size;
        panel_color = config.wayland.windowManager.hyprland.settings.config.decoration."col.shadow";
        workspace_active_background = "rgb(${config.lib.stylix.colors.base02})";
        workspace_active_border =
          config.wayland.windowManager.hyprland.settings.config.general."col.active_border";
        workspace_inactive_border =
          config.wayland.windowManager.hyprland.settings.config.general."col.inactive_border";
        workspace_border_size = config.wayland.windowManager.hyprland.settings.config.general.border_size;
      };
    };
  };
}
