{ options, config, lib, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.desktops.common.kitty;
in
{
  options.custom.desktops.common.kitty = with types; {
    enable = mkBoolOpt config.custom.desktops.common.enable "Enable kitty terminal emulator";
  };

  config = mkIf cfg.enable {
    # A modern, hackable, featureful, OpenGL based terminal emulator
    # https://github.com/kovidgoyal/kitty
    programs.kitty = {
      enable = true;

      settings = {
        # https://sw.kovidgoyal.net/kitty/conf/

        # Scrollback
        scrollback_lines = 10000;

        # Mouse
        copy_on_select = "clipboard";

        # Terminal Bell
        enable_audio_bell = false;
        visual_bell_duration = "1.0";

        # window layout
        window_border_width = "5px";
        active_border_color = "none";
        inactive_border_color = "#${config.lib.stylix.colors.base01}";
        inactive_text_alpha = "0.9";
        #draw_minimal_borders = false;
        #window_margin_width = 1;
        window_padding_width = 5;
        confirm_os_window_close = 0;

        # Color scheme
        #background_opacity = lib.mkDefault "0.85";

        # Advanced
        update_check_interval = 0;

        # Keyboard Shortcuts
        kitty_mod = "ctrl+shift";
      };

      keybindings = {
        # https://sw.kovidgoyal.net/kitty/conf/#keyboard-shortcuts

        # Scrolling
        "kitty_mod+[" = "scroll_to_prompt -1";
        "kitty_mod+]" = "scroll_to_prompt 1";

        # Window management
        "kitty_mod+up" = "next_window";
        "kitty_mod+down" = "previous_window";
      };
    };

    #$ kitty --session
    xdg.configFile = {
      "kitty/idleinhibitor".text = ''
        os_window_class idleinhibitor
        launch --title idleinhibit "hyprctl activewindow"

        new_tab
      '';
      "kitty/wallpaper".text = ''
        os_window_class wallpaper

        layout fat:mirrored=true;bias=60;full_size=1
        launch ${pkgs.btop}/bin/btop
        launch ${pkgs.asciiquarium}/bin/asciiquarium
        launch ${pkgs.peaclock}/bin/peaclock
        launch ${pkgs.pipes}/bin/pipes.sh -f20 -s12 -t1

        new_tab
        launch --title "kitty" ${config.programs.kitty.package}/bin/kitten @

        new_tab
        launch
      '';
    };

    wayland.windowManager.hyprland.settings = {
      exec-once = [ "[workspace name:D silent] ${config.programs.kitty.package}/bin/kitty --start-as=maximized --session wallpaper" ];
      windowrulev2 = [
        "idleinhibit always, class:idleinhibitor, floating:1"

        "noborder, class:wallpaper"
      ];
    };
  };
}
