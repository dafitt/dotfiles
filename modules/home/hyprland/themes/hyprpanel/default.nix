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
    # https://hyprpanel.com/configuration/settings.html
    programs.hyprpanel = {
      enable = true;
      overwrite.enable = true;

      layout."bar.layouts" = {
        "0" = {
          # https://hyprpanel.com/configuration/modules.html
          left = [ "workspaces" "windowtitle" ];
          middle = [ "systray" "notifications" "clock" "media" ];
          right = [ "bluetooth" "network" "volume" "hypridle" "battery" "dashboard" ];
        };
      };
      settings = {
        bar.bluetooth.label = false;
        bar.clock.format = "%Y-%m-%d  %R";
        bar.customModules.hypridle.label = false;
        bar.customModules.hypridle.offIcon = ""; # swapped icons
        bar.customModules.hypridle.onIcon = ""; # swapped icons
        bar.launcher.autoDetectIcon = true;
        bar.network.label = false;
        bar.workspaces.ignored = "^-\\\\d\\\\d?$"; # -> "^-\\d\\d?$"
        bar.workspaces.reverse_scroll = true;
        bar.workspaces.show_numbered = true;
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
        theme.osd.location = "bottom";
        theme.osd.margins = "80px";
        theme.osd.orientation = "horizontal";
      };

      override =
        with config.lib.stylix.colors.withHashtag; {
          # Color Theme
          #TODO upstream themes{default,switch,vivid,...} to stylix
          "theme.bar.menus.menu.notifications.scrollbar.color" = base07;
          "theme.bar.menus.menu.notifications.pager.label" = base04;
          "theme.bar.menus.menu.notifications.pager.button" = base07;
          "theme.bar.menus.menu.notifications.pager.background" = base00;
          "theme.bar.menus.menu.notifications.switch.puck" = base03;
          "theme.bar.menus.menu.notifications.switch.disabled" = base02;
          "theme.bar.menus.menu.notifications.switch.enabled" = base07;
          "theme.bar.menus.menu.notifications.clear" = base08;
          "theme.bar.menus.menu.notifications.switch_divider" = base03;
          "theme.bar.menus.menu.notifications.border" = base02;
          "theme.bar.menus.menu.notifications.card" = base00;
          "theme.bar.menus.menu.notifications.background" = base00;
          "theme.bar.menus.menu.notifications.no_notifications_label" = base02;
          "theme.bar.menus.menu.notifications.label" = base07;
          "theme.bar.menus.menu.power.buttons.sleep.icon" = base01;
          "theme.bar.menus.menu.power.buttons.sleep.text" = base0C;
          "theme.bar.menus.menu.power.buttons.sleep.icon_background" = base0C;
          "theme.bar.menus.menu.power.buttons.sleep.background" = base00;
          "theme.bar.menus.menu.power.buttons.logout.icon" = base01;
          "theme.bar.menus.menu.power.buttons.logout.text" = base0B;
          "theme.bar.menus.menu.power.buttons.logout.icon_background" = base0B;
          "theme.bar.menus.menu.power.buttons.logout.background" = base00;
          "theme.bar.menus.menu.power.buttons.restart.icon" = base01;
          "theme.bar.menus.menu.power.buttons.restart.text" = base09;
          "theme.bar.menus.menu.power.buttons.restart.icon_background" = base09;
          "theme.bar.menus.menu.power.buttons.restart.background" = base00;
          "theme.bar.menus.menu.power.buttons.shutdown.icon" = base01;
          "theme.bar.menus.menu.power.buttons.shutdown.text" = base08;
          "theme.bar.menus.menu.power.buttons.shutdown.icon_background" = base08;
          "theme.bar.menus.menu.power.buttons.shutdown.background" = base00;
          "theme.bar.menus.menu.power.border.color" = base02;
          "theme.bar.menus.menu.power.background.color" = base00;
          "theme.bar.menus.menu.dashboard.monitors.disk.label" = base0F;
          "theme.bar.menus.menu.dashboard.monitors.disk.bar" = base0F;
          "theme.bar.menus.menu.dashboard.monitors.disk.icon" = base0F;
          "theme.bar.menus.menu.dashboard.monitors.gpu.label" = base0B;
          "theme.bar.menus.menu.dashboard.monitors.gpu.bar" = base0B;
          "theme.bar.menus.menu.dashboard.monitors.gpu.icon" = base0B;
          "theme.bar.menus.menu.dashboard.monitors.ram.label" = base0A;
          "theme.bar.menus.menu.dashboard.monitors.ram.bar" = base0A;
          "theme.bar.menus.menu.dashboard.monitors.ram.icon" = base0A;
          "theme.bar.menus.menu.dashboard.monitors.cpu.label" = base08;
          "theme.bar.menus.menu.dashboard.monitors.cpu.bar" = base08;
          "theme.bar.menus.menu.dashboard.monitors.cpu.icon" = base08;
          "theme.bar.menus.menu.dashboard.monitors.bar_background" = base03;
          "theme.bar.menus.menu.dashboard.directories.right.bottom.color" = base07;
          "theme.bar.menus.menu.dashboard.directories.right.middle.color" = base0E;
          "theme.bar.menus.menu.dashboard.directories.right.top.color" = base0C;
          "theme.bar.menus.menu.dashboard.directories.left.bottom.color" = base08;
          "theme.bar.menus.menu.dashboard.directories.left.middle.color" = base0A;
          "theme.bar.menus.menu.dashboard.directories.left.top.color" = base0F;
          "theme.bar.menus.menu.dashboard.controls.input.text" = base01;
          "theme.bar.menus.menu.dashboard.controls.input.background" = base0F;
          "theme.bar.menus.menu.dashboard.controls.volume.text" = base01;
          "theme.bar.menus.menu.dashboard.controls.volume.background" = base08;
          "theme.bar.menus.menu.dashboard.controls.notifications.text" = base01;
          "theme.bar.menus.menu.dashboard.controls.notifications.background" = base0A;
          "theme.bar.menus.menu.dashboard.controls.bluetooth.text" = base01;
          "theme.bar.menus.menu.dashboard.controls.bluetooth.background" = base0C;
          "theme.bar.menus.menu.dashboard.controls.wifi.text" = base01;
          "theme.bar.menus.menu.dashboard.controls.wifi.background" = base0E;
          "theme.bar.menus.menu.dashboard.controls.disabled" = base04;
          "theme.bar.menus.menu.dashboard.shortcuts.recording" = base0B;
          "theme.bar.menus.menu.dashboard.shortcuts.text" = base01;
          "theme.bar.menus.menu.dashboard.shortcuts.background" = base07;
          "theme.bar.menus.menu.dashboard.powermenu.confirmation.button_text" = base00;
          "theme.bar.menus.menu.dashboard.powermenu.confirmation.deny" = base08;
          "theme.bar.menus.menu.dashboard.powermenu.confirmation.confirm" = base0B;
          "theme.bar.menus.menu.dashboard.powermenu.confirmation.body" = base05;
          "theme.bar.menus.menu.dashboard.powermenu.confirmation.label" = base07;
          "theme.bar.menus.menu.dashboard.powermenu.confirmation.border" = base02;
          "theme.bar.menus.menu.dashboard.powermenu.confirmation.background" = base00;
          "theme.bar.menus.menu.dashboard.powermenu.confirmation.card" = base00;
          "theme.bar.menus.menu.dashboard.powermenu.sleep" = base0C;
          "theme.bar.menus.menu.dashboard.powermenu.logout" = base0B;
          "theme.bar.menus.menu.dashboard.powermenu.restart" = base09;
          "theme.bar.menus.menu.dashboard.powermenu.shutdown" = base08;
          "theme.bar.menus.menu.dashboard.profile.name" = base0F;
          "theme.bar.menus.menu.dashboard.border.color" = base02;
          "theme.bar.menus.menu.dashboard.background.color" = base00;
          "theme.bar.menus.menu.dashboard.card.color" = base00;
          "theme.bar.menus.menu.clock.weather.hourly.temperature" = base0F;
          "theme.bar.menus.menu.clock.weather.hourly.icon" = base0F;
          "theme.bar.menus.menu.clock.weather.hourly.time" = base0F;
          "theme.bar.menus.menu.clock.weather.thermometer.extremelycold" = base0C;
          "theme.bar.menus.menu.clock.weather.thermometer.cold" = base0D;
          "theme.bar.menus.menu.clock.weather.thermometer.moderate" = base07;
          "theme.bar.menus.menu.clock.weather.thermometer.hot" = base09;
          "theme.bar.menus.menu.clock.weather.thermometer.extremelyhot" = base08;
          "theme.bar.menus.menu.clock.weather.stats" = base0F;
          "theme.bar.menus.menu.clock.weather.status" = base0C;
          "theme.bar.menus.menu.clock.weather.temperature" = base05;
          "theme.bar.menus.menu.clock.weather.icon" = base0F;
          "theme.bar.menus.menu.clock.calendar.contextdays" = base04;
          "theme.bar.menus.menu.clock.calendar.days" = base05;
          "theme.bar.menus.menu.clock.calendar.currentday" = base0F;
          "theme.bar.menus.menu.clock.calendar.paginator" = base0F;
          "theme.bar.menus.menu.clock.calendar.weekdays" = base0F;
          "theme.bar.menus.menu.clock.calendar.yearmonth" = base0C;
          "theme.bar.menus.menu.clock.time.timeperiod" = base0C;
          "theme.bar.menus.menu.clock.time.time" = base0F;
          "theme.bar.menus.menu.clock.text" = base05;
          "theme.bar.menus.menu.clock.border.color" = base02;
          "theme.bar.menus.menu.clock.background.color" = base00;
          "theme.bar.menus.menu.clock.card.color" = base00;
          "theme.bar.menus.menu.battery.slider.puck" = base04;
          "theme.bar.menus.menu.battery.slider.backgroundhover" = base03;
          "theme.bar.menus.menu.battery.slider.background" = base04;
          "theme.bar.menus.menu.battery.slider.primary" = base0A;
          "theme.bar.menus.menu.battery.icons.active" = base0A;
          "theme.bar.menus.menu.battery.icons.passive" = base04;
          "theme.bar.menus.menu.battery.listitems.active" = base0A;
          "theme.bar.menus.menu.battery.listitems.passive" = base05;
          "theme.bar.menus.menu.battery.text" = base05;
          "theme.bar.menus.menu.battery.label.color" = base0A;
          "theme.bar.menus.menu.battery.border.color" = base02;
          "theme.bar.menus.menu.battery.background.color" = base00;
          "theme.bar.menus.menu.battery.card.color" = base00;
          "theme.bar.menus.menu.systray.dropdownmenu.divider" = base00;
          "theme.bar.menus.menu.systray.dropdownmenu.text" = base05;
          "theme.bar.menus.menu.systray.dropdownmenu.background" = base00;
          "theme.bar.menus.menu.bluetooth.iconbutton.active" = base0C;
          "theme.bar.menus.menu.bluetooth.iconbutton.passive" = base05;
          "theme.bar.menus.menu.bluetooth.icons.active" = base0C;
          "theme.bar.menus.menu.bluetooth.icons.passive" = base04;
          "theme.bar.menus.menu.bluetooth.listitems.active" = base0C;
          "theme.bar.menus.menu.bluetooth.listitems.passive" = base05;
          "theme.bar.menus.menu.bluetooth.switch.puck" = base03;
          "theme.bar.menus.menu.bluetooth.switch.disabled" = base02;
          "theme.bar.menus.menu.bluetooth.switch.enabled" = base0C;
          "theme.bar.menus.menu.bluetooth.switch_divider" = base03;
          "theme.bar.menus.menu.bluetooth.status" = base04;
          "theme.bar.menus.menu.bluetooth.text" = base05;
          "theme.bar.menus.menu.bluetooth.label.color" = base0C;
          "theme.bar.menus.menu.bluetooth.scroller.color" = base0C;
          "theme.bar.menus.menu.bluetooth.border.color" = base02;
          "theme.bar.menus.menu.bluetooth.background.color" = base00;
          "theme.bar.menus.menu.bluetooth.card.color" = base00;
          "theme.bar.menus.menu.network.switch.puck" = base03;
          "theme.bar.menus.menu.network.switch.disabled" = base02;
          "theme.bar.menus.menu.network.switch.enabled" = base0E;
          "theme.bar.menus.menu.network.iconbuttons.active" = base0E;
          "theme.bar.menus.menu.network.iconbuttons.passive" = base05;
          "theme.bar.menus.menu.network.icons.active" = base0E;
          "theme.bar.menus.menu.network.icons.passive" = base04;
          "theme.bar.menus.menu.network.listitems.active" = base0E;
          "theme.bar.menus.menu.network.listitems.passive" = base05;
          "theme.bar.menus.menu.network.status.color" = base04;
          "theme.bar.menus.menu.network.text" = base05;
          "theme.bar.menus.menu.network.label.color" = base0E;
          "theme.bar.menus.menu.network.scroller.color" = base0E;
          "theme.bar.menus.menu.network.border.color" = base02;
          "theme.bar.menus.menu.network.background.color" = base00;
          "theme.bar.menus.menu.network.card.color" = base00;
          "theme.bar.menus.menu.volume.input_slider.puck" = base04;
          "theme.bar.menus.menu.volume.input_slider.backgroundhover" = base03;
          "theme.bar.menus.menu.volume.input_slider.background" = base04;
          "theme.bar.menus.menu.volume.input_slider.primary" = base08;
          "theme.bar.menus.menu.volume.audio_slider.puck" = base04;
          "theme.bar.menus.menu.volume.audio_slider.backgroundhover" = base03;
          "theme.bar.menus.menu.volume.audio_slider.background" = base04;
          "theme.bar.menus.menu.volume.audio_slider.primary" = base08;
          "theme.bar.menus.menu.volume.icons.active" = base08;
          "theme.bar.menus.menu.volume.icons.passive" = base04;
          "theme.bar.menus.menu.volume.iconbutton.active" = base08;
          "theme.bar.menus.menu.volume.iconbutton.passive" = base05;
          "theme.bar.menus.menu.volume.listitems.active" = base08;
          "theme.bar.menus.menu.volume.listitems.passive" = base05;
          "theme.bar.menus.menu.volume.text" = base05;
          "theme.bar.menus.menu.volume.label.color" = base08;
          "theme.bar.menus.menu.volume.border.color" = base02;
          "theme.bar.menus.menu.volume.background.color" = base00;
          "theme.bar.menus.menu.volume.card.color" = base00;
          "theme.bar.menus.menu.media.slider.puck" = base04;
          "theme.bar.menus.menu.media.slider.backgroundhover" = base03;
          "theme.bar.menus.menu.media.slider.background" = base04;
          "theme.bar.menus.menu.media.slider.primary" = base0F;
          "theme.bar.menus.menu.media.buttons.text" = base00;
          "theme.bar.menus.menu.media.buttons.background" = base07;
          "theme.bar.menus.menu.media.buttons.enabled" = base0C;
          "theme.bar.menus.menu.media.buttons.inactive" = base04;
          "theme.bar.menus.menu.media.border.color" = base02;
          "theme.bar.menus.menu.media.card.color" = base00;
          "theme.bar.menus.menu.media.background.color" = base00;
          "theme.bar.menus.menu.media.album" = base0F;
          "theme.bar.menus.menu.media.timestamp" = base05;
          "theme.bar.menus.menu.media.artist" = base0C;
          "theme.bar.menus.menu.media.song" = base07;
          "theme.bar.menus.tooltip.text" = base05;
          "theme.bar.menus.tooltip.background" = base00;
          "theme.bar.menus.dropdownmenu.divider" = base00;
          "theme.bar.menus.dropdownmenu.text" = base05;
          "theme.bar.menus.dropdownmenu.background" = base00;
          "theme.bar.menus.slider.puck" = base04;
          "theme.bar.menus.slider.backgroundhover" = base03;
          "theme.bar.menus.slider.background" = base04;
          "theme.bar.menus.slider.primary" = base07;
          "theme.bar.menus.progressbar.background" = base03;
          "theme.bar.menus.progressbar.foreground" = base07;
          "theme.bar.menus.iconbuttons.active" = base07;
          "theme.bar.menus.iconbuttons.passive" = base05;
          "theme.bar.menus.buttons.text" = base01;
          "theme.bar.menus.buttons.disabled" = base04;
          "theme.bar.menus.buttons.active" = base0F;
          "theme.bar.menus.buttons.default" = base07;
          "theme.bar.menus.check_radio_button.active" = base07;
          "theme.bar.menus.check_radio_button.background" = base03;
          "theme.bar.menus.switch.puck" = base03;
          "theme.bar.menus.switch.disabled" = base02;
          "theme.bar.menus.switch.enabled" = base07;
          "theme.bar.menus.icons.active" = base07;
          "theme.bar.menus.icons.passive" = base04;
          "theme.bar.menus.listitems.active" = base07;
          "theme.bar.menus.listitems.passive" = base05;
          "theme.bar.menus.popover.border" = base02;
          "theme.bar.menus.popover.background" = base01;
          "theme.bar.menus.popover.text" = base05;
          "theme.bar.menus.label" = base05;
          "theme.bar.menus.feinttext" = base02;
          "theme.bar.menus.dimtext" = base04;
          "theme.bar.menus.text" = base05;
          "theme.bar.menus.border.color" = base02;
          "theme.bar.menus.cards" = base00;
          "theme.bar.menus.background" = base00;
          "theme.bar.buttons.modules.submap.icon_background" = base0C;
          "theme.bar.buttons.modules.submap.icon" = base02;
          "theme.bar.buttons.modules.submap.text" = base02;
          "theme.bar.buttons.modules.submap.background" = base0C;
          "theme.bar.buttons.modules.submap.border" = base0C;
          "theme.bar.buttons.modules.power.icon_background" = base08;
          "theme.bar.buttons.modules.power.icon" = base02;
          "theme.bar.buttons.modules.power.background" = base08;
          "theme.bar.buttons.modules.power.border" = base08;
          "theme.bar.buttons.modules.weather.icon_background" = base07;
          "theme.bar.buttons.modules.weather.icon" = base02;
          "theme.bar.buttons.modules.weather.text" = base02;
          "theme.bar.buttons.modules.weather.background" = base07;
          "theme.bar.buttons.modules.weather.border" = base07;
          "theme.bar.buttons.modules.updates.icon_background" = base0E;
          "theme.bar.buttons.modules.updates.icon" = base02;
          "theme.bar.buttons.modules.updates.text" = base02;
          "theme.bar.buttons.modules.updates.background" = base0E;
          "theme.bar.buttons.modules.updates.border" = base0E;
          "theme.bar.buttons.modules.kbLayout.icon_background" = base0C;
          "theme.bar.buttons.modules.kbLayout.icon" = base02;
          "theme.bar.buttons.modules.kbLayout.text" = base02;
          "theme.bar.buttons.modules.kbLayout.background" = base0C;
          "theme.bar.buttons.modules.kbLayout.border" = base0C;
          "theme.bar.buttons.modules.netstat.icon_background" = base0B;
          "theme.bar.buttons.modules.netstat.icon" = base02;
          "theme.bar.buttons.modules.netstat.text" = base02;
          "theme.bar.buttons.modules.netstat.background" = base0B;
          "theme.bar.buttons.modules.netstat.border" = base0B;
          "theme.bar.buttons.modules.storage.icon_background" = base0F;
          "theme.bar.buttons.modules.storage.icon" = base02;
          "theme.bar.buttons.modules.storage.text" = base02;
          "theme.bar.buttons.modules.storage.background" = base0F;
          "theme.bar.buttons.modules.storage.border" = base0F;
          "theme.bar.buttons.modules.cpu.icon_background" = base08;
          "theme.bar.buttons.modules.cpu.icon" = base02;
          "theme.bar.buttons.modules.cpu.text" = base02;
          "theme.bar.buttons.modules.cpu.background" = base08;
          "theme.bar.buttons.modules.cpu.border" = base08;
          "theme.bar.buttons.modules.ram.icon_background" = base0A;
          "theme.bar.buttons.modules.ram.icon" = base02;
          "theme.bar.buttons.modules.ram.text" = base02;
          "theme.bar.buttons.modules.ram.background" = base0A;
          "theme.bar.buttons.modules.ram.border" = base0A;
          "theme.bar.buttons.notifications.total" = base02;
          "theme.bar.buttons.notifications.icon_background" = base07;
          "theme.bar.buttons.notifications.icon" = base02;
          "theme.bar.buttons.notifications.background" = base07;
          "theme.bar.buttons.notifications.border" = base07;
          "theme.bar.buttons.clock.icon_background" = base0F;
          "theme.bar.buttons.clock.icon" = base02;
          "theme.bar.buttons.clock.text" = base02;
          "theme.bar.buttons.clock.background" = base0F;
          "theme.bar.buttons.clock.border" = base0F;
          "theme.bar.buttons.battery.icon_background" = base0A;
          "theme.bar.buttons.battery.icon" = base02;
          "theme.bar.buttons.battery.text" = base02;
          "theme.bar.buttons.battery.background" = base0A;
          "theme.bar.buttons.battery.border" = base0A;
          "theme.bar.buttons.systray.background" = base02;
          "theme.bar.buttons.systray.border" = base07;
          "theme.bar.buttons.systray.customIcon" = base05;
          "theme.bar.buttons.bluetooth.icon_background" = base0C;
          "theme.bar.buttons.bluetooth.icon" = base02;
          "theme.bar.buttons.bluetooth.text" = base02;
          "theme.bar.buttons.bluetooth.background" = base0C;
          "theme.bar.buttons.bluetooth.border" = base0C;
          "theme.bar.buttons.network.icon_background" = base05;
          "theme.bar.buttons.network.icon" = base02;
          "theme.bar.buttons.network.text" = base02;
          "theme.bar.buttons.network.background" = base0E;
          "theme.bar.buttons.network.border" = base0E;
          "theme.bar.buttons.volume.icon_background" = base08;
          "theme.bar.buttons.volume.icon" = base02;
          "theme.bar.buttons.volume.text" = base02;
          "theme.bar.buttons.volume.background" = base08;
          "theme.bar.buttons.volume.border" = base08;
          "theme.bar.buttons.media.icon_background" = base07;
          "theme.bar.buttons.media.icon" = base02;
          "theme.bar.buttons.media.text" = base02;
          "theme.bar.buttons.media.background" = base07;
          "theme.bar.buttons.media.border" = base07;
          "theme.bar.buttons.windowtitle.icon_background" = base0F;
          "theme.bar.buttons.windowtitle.icon" = base02;
          "theme.bar.buttons.windowtitle.text" = base02;
          "theme.bar.buttons.windowtitle.border" = base0F;
          "theme.bar.buttons.windowtitle.background" = base0F;
          "theme.bar.buttons.workspaces.numbered_active_underline_color" = base0F;
          "theme.bar.buttons.workspaces.numbered_active_highlighted_text_color" = base01;
          "theme.bar.buttons.workspaces.hover" = base0F;
          "theme.bar.buttons.workspaces.active" = base0F;
          "theme.bar.buttons.workspaces.occupied" = base0F;
          "theme.bar.buttons.workspaces.available" = base0C;
          "theme.bar.buttons.workspaces.border" = base0F;
          "theme.bar.buttons.workspaces.background" = base02;
          "theme.bar.buttons.dashboard.icon" = base02;
          "theme.bar.buttons.dashboard.border" = base0A;
          "theme.bar.buttons.dashboard.background" = base0A;
          "theme.bar.buttons.icon" = base07;
          "theme.bar.buttons.text" = base07;
          "theme.bar.buttons.hover" = base03;
          "theme.bar.buttons.icon_background" = base02;
          "theme.bar.buttons.background" = base02;
          "theme.bar.buttons.borderColor" = base07;
          "theme.bar.buttons.style" = "default";
          "theme.bar.background" = base00;
          "theme.osd.label" = base07;
          "theme.osd.icon" = base00;
          "theme.osd.bar_overflow_color" = base08;
          "theme.osd.bar_empty_color" = base02;
          "theme.osd.bar_color" = base07;
          "theme.osd.icon_container" = base07;
          "theme.osd.bar_container" = base03;
          "theme.notification.close_button.label" = base00;
          "theme.notification.close_button.background" = base08;
          "theme.notification.labelicon" = base07;
          "theme.notification.text" = base05;
          "theme.notification.time" = base04;
          "theme.notification.border" = base02;
          "theme.notification.label" = base07;
          "theme.notification.actions.text" = base01;
          "theme.notification.actions.background" = base07;
          "theme.notification.background" = base01;
          "theme.bar.border.color" = base07;
          "theme.bar.buttons.modules.hyprsunset.icon" = base02;
          "theme.bar.buttons.modules.hyprsunset.background" = base09;
          "theme.bar.buttons.modules.hyprsunset.icon_background" = base09;
          "theme.bar.buttons.modules.hyprsunset.text" = base02;
          "theme.bar.buttons.modules.hyprsunset.border" = base09;
          "theme.bar.buttons.modules.hypridle.icon" = base02;
          "theme.bar.buttons.modules.hypridle.background" = base0F;
          "theme.bar.buttons.modules.hypridle.icon_background" = base0F;
          "theme.bar.buttons.modules.hypridle.text" = base02;
          "theme.bar.buttons.modules.hypridle.border" = base0F;
          "theme.bar.buttons.modules.cava.background" = base0C;
          "theme.bar.buttons.modules.cava.text" = base02;
          "theme.bar.buttons.modules.cava.icon" = base02;
          "theme.bar.buttons.modules.cava.icon_background" = base0C;
          "theme.bar.buttons.modules.cava.border" = base0C;
          #* Own Theme Modifications:
          #* (text.*)base07;$ -> $1base05;
          #* (border.*)base01;$ -> $1base02;
          #* (osd\.bar_container.*)base00;$ -> $1base02;
        };
    };

    wayland.windowManager.hyprland.settings = {
      bind = [ "SUPER, W, exec, hyprpanel toggleWindow bar-0" ];
      exec-once = [ "uwsm app -- ${pkgs.hyprpanel}/bin/hyprpanel" ];
      exec = [ "${pkgs.hyprpanel}/bin/hyprpanel --quit; uwsm app -- ${pkgs.hyprpanel}/bin/hyprpanel" ];
    };
  };
}
