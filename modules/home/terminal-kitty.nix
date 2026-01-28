{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib;
let
  cfg = config.dafitt.terminal-kitty;

  kittyExe = getExe config.programs.kitty.package;
in
{
  imports = with inputs; [
    noctalia.homeModules.default
    self.homeModules.pyprland
    self.homeModules.stylix
  ];

  options.dafitt.terminal-kitty = with types; {
    setAsDefaultTerminal = mkEnableOption "making it the default TERM";
  };

  config = mkMerge [
    {
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

      wayland.windowManager.hyprland.settings = {
        windowrule = [
          "match:class idleinhibitor, match:float 1, idle_inhibit always"
        ];
        bind = optionals config.dafitt.pyprland.enable [
          "Super&Alt, T, exec, ${pkgs.pyprland}/bin/pypr toggle kitty"
        ];
      };
      dafitt.pyprland.scratchpads.kitty = {
        animation = "fromTop";
        command = "uwsm app -- ${kittyExe} --class dropterm --hold ${getExe config.programs.fastfetch.package}";
        class = "dropterm";
        size = "90% 90%";
        margin = "2%";
        lazy = true;
      };
    }

    (mkIf cfg.setAsDefaultTerminal {
      home.sessionVariables.TERMINAL = kittyExe;

      programs.fuzzel.settings.main.terminal = kittyExe;
      programs.rofi.terminal = kittyExe;
      programs.noctalia-shell.settings.appLauncher.terminalCommand = kittyExe;

      wayland.windowManager.hyprland.settings = {
        bind = [ "Super, RETURN, exec, uwsm app -- ${kittyExe}" ];
      };
      programs.niri.settings.binds."Mod+Return".action.spawn = [
        "uwsm"
        "app"
        "--"
        kittyExe
      ];
    })
  ];
}
