{ config, lib, options, osConfig ? { }, pkgs, inputs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.desktops.gnome;
  osCfg = osConfig.custom.desktops.gnome or null;
in
{
  options.custom.desktops.gnome = with types; {
    enable = mkBoolOpt (osCfg.enable or true) "Enable Gnome configuration";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      gnome-extension-manager
    ] ++ (with pkgs.gnomeExtensions; [
      forge
    ]);

    dconf.settings = {

      # Extensions
      "org/gnome/shell" = {
        enabled-extensions = [
          "apps-menu@gnome-shell-extensions.gcampax.github.com"
          "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
          "forge@jmmaranan.com"
          "native-window-placement@gnome-shell-extensions.gcampax.github.com"
        ];
        favorite-apps = [
          "librewolf.desktop"
          "org.wezfurlong.wezterm.desktop"
          "org.gnome.Nautilus.desktop"
          "org.gnome.Calendar.desktop"
          "obsidian.desktop"
          "transmission-gtk.desktop"
          "caprine.desktop"
          "teams-for-linux.desktop"
          "discord.desktop"
          "spotify.desktop"
          "com.usebottles.bottles.desktop"
          "org.gnome.Software.desktop"
        ];
      };
      "org/gnome/shell/extensions/forge" = {
        stacked-tiling-mode-enabled = false;
        tabbed-tiling-mode-enabled = false;
        window-gap-hidden-on-single = true;
      };
      "org/gnome/shell/extensions/forge/keybindings" = {
        focus-border-toggle = [ "<Control><Super>b" ];
        window-focus-down = [ "<Super>Down" ];
        window-focus-left = [ "<Super>Left" ];
        window-focus-right = [ "<Super>Right" ];
        window-focus-up = [ "<Super>Up" ];
        window-move-down = [ "<Shift><Super>Down" ];
        window-move-left = [ "<Shift><Super>Left" ];
        window-move-right = [ "<Shift><Super>Right" ];
        window-move-up = [ "<Shift><Super>Up" ];
        window-resize-bottom-increase = [ "<Control><Super>Up" ];
      };
      "org/gnome/shell/extensions/auto-move-windows" = {
        application-list = [
          "librewolf.desktop:1"
          "org.gnome.Nautilus.desktop:2"
          "md.obsidian.Obsidian.desktop:3"
          "code.desktop:4"
        ];
      };

      # Desktop settings
      "org/gnome/desktop/input-sources" = {
        sources = [ [ "xkb" "de" ] ];
      };
      "org/gnome/desktop/peripherals/touchpad" = {
        tap-to-click = true;
        two-finger-scrolling-enabled = true;
      };
      "org/gnome/mutter" = {
        dynamic-workspaces = true;
        edge-tiling = true;
        num-workspaces = 6;
        workspaces-only-on-primary = true;
      };
      "org/gnome/desktop/wm/preferences" = {
        num-workspaces = 5;
        resize-with-right-button = true;
        focus-mode = "sloppy";
        visual-bell = true;
      };
      "org/gnome/desktop/wm/keybindings" = {
        close = [ "<Super>x" ];
        maximize = [ ];
        toggle-maximized = [ "<Super>a" ];
        toggle-fullscreen = [ "<Super>f" ];
        toggle-above = [ "<Super>b" ];
        minimize = [ "<Super>y" ];
        show-desktop = [ "<Super>d" ];
        move-to-workspace-1 = [ "<Shift><Super>1" ];
        move-to-workspace-2 = [ "<Shift><Super>2" ];
        move-to-workspace-3 = [ "<Shift><Super>3" ];
        move-to-workspace-4 = [ "<Shift><Super>4" ];
        move-to-workspace-5 = [ "<Shift><Super>5" ];
        move-to-workspace-6 = [ "<Shift><Super>6" ];
        move-to-workspace-7 = [ "<Shift><Super>7" ];
        move-to-workspace-8 = [ "<Shift><Super>8" ];
        move-to-workspace-9 = [ "<Shift><Super>9" ];
        move-to-workspace-10 = [ "<Shift><Super>0" ];
        switch-to-workspace-1 = [ "<Super>1" ];
        switch-to-workspace-2 = [ "<Super>2" ];
        switch-to-workspace-3 = [ "<Super>3" ];
        switch-to-workspace-4 = [ "<Super>4" ];
        switch-to-workspace-5 = [ "<Super>5" ];
        switch-to-workspace-6 = [ "<Super>6" ];
        switch-to-workspace-7 = [ "<Super>7" ];
        switch-to-workspace-8 = [ "<Super>8" ];
        switch-to-workspace-9 = [ "<Super>9" ];
        switch-to-workspace-10 = [ "<Super>0" ];
        move-to-monitor-down = [ ];
        move-to-monitor-left = [ ];
        move-to-monitor-right = [ ];
        move-to-monitor-up = [ ];
        unmaximize = [ ];
      };
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        binding = "<Super>Return";
        command = "kitty";
        name = "Terminal";
      };
      "org/gnome/shell/keybindings" = {
        switch-to-application-1 = [ ];
        switch-to-application-2 = [ ];
        switch-to-application-3 = [ ];
        switch-to-application-4 = [ ];
        switch-to-application-5 = [ ];
        switch-to-application-6 = [ ];
        switch-to-application-7 = [ ];
        switch-to-application-8 = [ ];
        switch-to-application-9 = [ ];
        toggle-application-view = [ ];
      };
      "org/gnome/shell/window-switcher" = {
        current-workspace-only = false;
      };
      "org/gnome/gnome-session" = {
        auto-save-session = true;
        logout-prompt = false;
      };
      "org/gnome/session" = { idle-delay = 0; };
    };
  };
}
