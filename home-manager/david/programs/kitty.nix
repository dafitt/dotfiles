{ config, pkgs, ... }: {

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
      launch
      launch ${pkgs.pipes}/bin/pipes.sh -f20 -s14 -t1

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
}
