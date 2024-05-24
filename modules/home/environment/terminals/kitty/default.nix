{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  terminalsCfg = config.dafitt.environment.terminals;
  cfg = terminalsCfg.kitty;

  isDefault = terminalsCfg.default == "kitty";
in
{
  options.dafitt.environment.terminals.kitty = with types; {
    enable = mkBoolOpt isDefault "Enable the kitty terminal emulator.";
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
      "kitty/D".text = ''
        os_window_class D

        launch ${pkgs.btop}/bin/btop

        new_tab
        launch --title "kitty" ${config.programs.kitty.package}/bin/kitten @

        new_tab
        launch
      '';
    };

    # this option is being used by other modules
    home.sessionVariables.TERMINAL = mkIf isDefault "${getExe config.programs.kitty.package}";

    wayland.windowManager.hyprland.settings = {
      exec-once = [ "[workspace name:D silent] ${config.programs.kitty.package}/bin/kitty --start-as=maximized --session D" ];
      windowrulev2 = [
        "idleinhibit always, class:idleinhibitor, floating:1"
        "noborder, class:wallpaper"
      ];
    } // optionalAttrs isDefault {
      bind = [
        "SUPER, RETURN, exec, ${getExe config.programs.kitty.package}"
        "SUPER_ALT, T, exec, ${getExe config.programs.kitty.package}"
      ];
    };
  };
}
