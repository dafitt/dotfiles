{ options, config, lib, pkgs, inputs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.hyprland.plugins.hyprspace;
in
{
  options.dafitt.hyprland.plugins.hyprspace = with types; {
    enable = mkEnableOption "hyprspace";
  };

  config = mkIf cfg.enable {
    dafitt.stylix.enable = true;
    dafitt.hyprland.plugins.hyprexpo.enable = false;

    wayland.windowManager.hyprland = {
      # https://github.com/KZDKM/Hyprspace
      plugins = [ pkgs.hyprlandPlugins.hyprspace ];

      settings.bind = [ "SUPER, ASCIICIRCUM, overview:toggle, " ];

      # https://github.com/KZDKM/Hyprspace?tab=readme-ov-file#configuration
      settings.plugin.overview = {
        # behaviour
        exitOnSwitch = true;

        # theming
        drawActiveWorkspace = false;
        panelBorderColor = "rgb(${config.lib.stylix.colors.base0C})";
        panelBorderWidth = config.wayland.windowManager.hyprland.settings.general.border_size;
        panelColor = config.wayland.windowManager.hyprland.settings.decoration."col.shadow";
        workspaceActiveBackground = "rgb(${config.lib.stylix.colors.base02})";
        workspaceActiveBorder = config.wayland.windowManager.hyprland.settings.general."col.active_border";
        workspaceInactiveBorder = config.wayland.windowManager.hyprland.settings.general."col.inactive_border";
        workspaceBorderSize = config.wayland.windowManager.hyprland.settings.general.border_size;
      };
    };
  };
}
