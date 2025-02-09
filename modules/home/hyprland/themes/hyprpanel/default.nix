{ options, config, lib, pkgs, inputs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.hyprland.themes.hyprpanel;
  hyprlandCfg = config.wayland.windowManager.hyprland;
in
{
  options.dafitt.hyprland.themes.hyprpanel = with types; {
    enable = mkEnableOption "the hyprpanel theme";
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.hyprpanel ];

    # https://github.com/Jas-SinghFSU/HyprPanel/blob/master/nix/module.nix#L65
    # https://hyprpanel.com/configuration/panel.html
    programs.hyprpanel = {
      enable = true;
      hyprland.enable = true;
      overwrite.enable = true;

      layout."bar.layouts" = {
        "0" = {
          left = [ "workspaces" "windowtitle" ];
          middle = [ "clock" "media" ];
          right = [ "systray" "notifications" "battery" "volume" "bluetooth" "network" "dashboard" ];
        };
      };
      theme = "catppuccin_mocha_vivid";
      settings = {
        bar.clock.format = "%Y-%m-%d  %R";
        bar.launcher.autoDetectIcon = true;
        bar.workspaces.reverse_scroll = true;
        bar.workspaces.show_icons = true;
        menus.clock.time.military = true;
        menus.clock.weather.unit = "metric";
        menus.dashboard.directories.enabled = false;
        menus.dashboard.stats.enable_gpu = true;
        theme.bar.buttons.radius = "${toString (hyprlandCfg.settings.decoration.rounding / 2)}px";
        theme.bar.menus.border.radius = "${toString hyprlandCfg.settings.decoration.rounding}px";
        theme.bar.menus.border.size = "${toString hyprlandCfg.settings.general.border_size}px";
        theme.bar.menus.buttons.radius = "${toString hyprlandCfg.settings.decoration.rounding}px";
        theme.bar.outer_spacing = "${toString hyprlandCfg.settings.general.gaps_out}px";
        theme.bar.transparent = true;
        theme.font.name = config.stylix.fonts.serif.name;
        theme.font.size = "${toString config.stylix.fonts.sizes.desktop}px";
      };
    };

    wayland.windowManager.hyprland.settings = {
      bind = [
        "SUPER, W, exec, hyprpanel toggleWindow bar-0"
      ];
    };
  };
}
