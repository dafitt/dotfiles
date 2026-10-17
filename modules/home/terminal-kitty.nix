{
  flake,
  config,
  lib,
  inputs,
  ...
}:
with lib;
let
  cfg = config.dafitt.terminal-kitty;

  kittyExe = getExe config.programs.kitty.package;
in
{
  #meta.doc = builtins.toFile "doc.md" ''
  #  Installs and configures the terminal emulator Kitty.
  #  <https://sw.kovidgoyal.net/kitty/>
  #'';

  imports = with inputs; [
    self.homeModules.home-manager-mutableFiles
    self.homeModules.stylix
  ];

  options.dafitt.terminal-kitty = with types; {
    setAsDefaultTerminal = mkEnableOption "making it the default TERM";
  };

  config = mkMerge [
    {
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
      xdg.configFile = flake.lib.mkMutableFiles [ "kitty/kitty.conf" ];
    }

    (mkIf cfg.setAsDefaultTerminal {
      home.sessionVariables.TERMINAL = kittyExe;

      programs.umbriel.settings.keybinds."Mod+Return" = {
        action = "spawn:" + kittyExe;
        repeat = false;
      };

      # dropterm
      programs.umbriel.settings = {
        keybinds."Mod+Alt+T" = {
          action = "scratchpad-toggle:dropterm";
          repeat = false;
        };
        scratchpad = [
          {
            name = "dropterm";
            spawn_when_empty = "${kittyExe} --class=dropterm --hold -e ${getExe config.programs.fastfetch.package}";
          }
        ];
        window_rule = [
          {
            match.app_id = "^dropterm$";
            default_scratchpad = "dropterm";
            default_floating_size = {
              width = 0.9;
              height = 0.9;
            };
            default_position = {
              anchor = "top";
              x = 0;
              y = 0;
            };
          }
        ];
      };

      dconf.settings."com/github/stunkymonkey/nautilus-open-any-terminal".terminal = "kitty";
    })
  ];
}
