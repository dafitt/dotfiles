{
  config,
  lib,
  pkgs,
  ...
}:

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

    # https://hyprpanel.com/configuration/settings.html
    # https://github.com/Jas-SinghFSU/HyprPanel/blob/master/src/components/settings/pages/config/general/index.tsx
    programs.hyprpanel = {
      enable = true;

      settings = {
        scalingPriority = "both";

        bar.layouts."0" = {
          # https://hyprpanel.com/configuration/modules.html
          left = [
            "workspaces"
            "windowtitle"
          ];
          middle = [
            "systray"
            "notifications"
            "clock"
            "media"
          ];
          right = [
            "bluetooth"
            "network"
            "volume"
            "hypridle"
            "battery"
            "dashboard"
          ];
        };
        bar.bluetooth.label = false;
        bar.clock.format = "%Y-%m-%d  %R";
        bar.customModules.hypridle.label = false;
        bar.customModules.hypridle.offIcon = ""; # swapped icons
        bar.customModules.hypridle.onIcon = ""; # swapped icons
        bar.launcher.autoDetectIcon = true;
        bar.network.label = false;
        bar.workspaces.ignored = "^-\\d\\d?$"; # -> "^-\d\d?$"
        bar.workspaces.reverse_scroll = true;
        bar.workspaces.show_numbered = true;
        menus.clock.time.military = true;
        menus.clock.weather.unit = "metric";
        menus.dashboard.directories.enabled = false;
        menus.dashboard.stats.enabled = false;
        theme.bar.buttons.radius = "${toString (hyprlandCfg.settings.decoration.rounding / 2)}px";
        theme.bar.floating = true;
        theme.bar.menus.border.radius = "${toString hyprlandCfg.settings.decoration.rounding}px";
        theme.bar.menus.border.size = "${toString hyprlandCfg.settings.general.border_size}px";
        theme.bar.menus.buttons.radius = "${toString hyprlandCfg.settings.decoration.rounding}px";
        theme.bar.outer_spacing = "${toString hyprlandCfg.settings.general.gaps_out}px";
        theme.bar.transparent = true;
        theme.font.name = config.stylix.fonts.serif.name;
        theme.font.size = "${toString config.stylix.fonts.sizes.desktop}px";
        theme.osd.location = "bottom";
        theme.osd.margins = "80px";
        theme.osd.orientation = "horizontal";
      };
    };

    systemd.user.services.hyprpanel = {
      Unit = {
        # FIXME upstream systemdTargets option
        After = mkForce "wayland-session@Hyprland.target";
        PartOf = mkForce "wayland-session@Hyprland.target";
      };
      Install.WantedBy = [ "wayland-session@Hyprland.target" ];
      Service = {
        Nice = "19";
      };
    };

    wayland.windowManager.hyprland.settings = {
      bind = [ "SUPER, W, exec, hyprpanel toggleWindow bar-0" ];
      exec = [ "${pkgs.systemd}/bin/systemctl --user restart hyprpanel.service" ];
    };
  };
}
