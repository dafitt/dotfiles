{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.kitty;
in
{
  options.dafitt.kitty = with types; {
    enable = mkEnableOption "`kitty`";
    setAsDefaultTerminal = mkEnableOption "making it the default TERM";
  };

  config = mkIf cfg.enable {
    dafitt.stylix.enable = true;

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
        inactive_border_color = config.lib.stylix.colors.withHashtag.base01;
        inactive_text_alpha = "0.9";
        window_padding_width = 5;
        confirm_os_window_close = 0;

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

    #$ kitty --session idleinhibitor
    xdg.configFile = {
      "kitty/idleinhibitor".text = ''
        os_window_class idleinhibitor
        launch --title idleinhibit "hyprctl activewindow"

        new_tab
      '';
    };

    # this option is being used by other modules
    home.sessionVariables.TERMINAL = mkIf cfg.setAsDefaultTerminal (
      getExe config.programs.kitty.package
    );

    wayland.windowManager.hyprland.settings = {
      bind =
        optionals cfg.setAsDefaultTerminal [
          "SUPER, RETURN, exec, uwsm app -- ${getExe config.programs.kitty.package}"
        ]
        ++ optionals config.dafitt.hyprland.pyprland.enable [
          "SUPER_ALT, T, exec, ${pkgs.pyprland}/bin/pypr toggle kitty"
        ];
      windowrule = [
        "idleinhibit always, class:idleinhibitor, floating:1"
      ];
    };

    dafitt.hyprland.pyprland.scratchpads.kitty = {
      animation = "fromTop";
      command = "uwsm app -- ${config.programs.kitty.package}/bin/kitty --class dropterm --hold ${getExe config.programs.fastfetch.package}";
      class = "dropterm";
      size = "90% 90%";
      margin = "2%";
      lazy = true;
    };
  };
}
