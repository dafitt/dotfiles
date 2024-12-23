{ options, config, lib, pkgs, inputs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.desktops.hyprland.plugins.hyprspace;
in
{
  options.dafitt.desktops.hyprland.plugins.hyprspace = with types; {
    enable = mkBoolOpt false "Whether to enable the hyprspace hyprland plugin.";
  };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      # https://github.com/KZDKM/Hyprspace
      plugins = with pkgs; [ inputs.hyprspace.packages.${system}.default ];

      settings.bind = [ "SUPER, asciicircum, overview:toggle, " ];

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
