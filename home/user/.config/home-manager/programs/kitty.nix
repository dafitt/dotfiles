{ pkgs, ... }: {

  # A modern, hackable, featureful, OpenGL based terminal emulator
  # https://github.com/kovidgoyal/kitty
  programs.kitty = {
    enable = true;
    # config <https://sw.kovidgoyal.net/kitty/conf/>
    keybindings = {
      "kitty_mod+up" = "scroll_to_prompt -1";
      "kitty_mod+down" = "scroll_to_prompt 1";
    };
    settings = {
      #background_opacity = lib.mkDefault "0.85";
      confirm_os_window_close = 0;
      copy_on_select = "clipboard";
      enable_audio_bell = false;
      hide_window_decorations = true;
      kitty_mod = "ctrl+shift";
      placement_strategy = "center";
      scrollback_lines = 10000;
      update_check_interval = 0;
    };
  };

  wayland.windowManager.hyprland.settings = {
    bind = [ ];
    exec-once = [ ];
    exec = [ ];
    windowrulev2 = [ ];
  };
}
