{
  flake,
  config,
  lib,
  inputs,
  ...
}:
with lib;
let
  cfg = config.dafitt.terminal-alacritty;

  exe = getExe config.programs.alacritty.package;
in
{
  #meta.doc = builtins.toFile "doc.md" ''
  #  Installs and configures the terminal emulator Alacritty.
  #  <https://alacritty.org/>
  #'';

  imports = with inputs; [
    self.homeModules.home-manager-mutableFiles
    self.homeModules.stylix
  ];

  options.dafitt.terminal-alacritty = with types; {
    setAsDefaultTerminal = mkEnableOption "making it the default TERM";
  };

  config = mkMerge [
    {
      programs.alacritty = {
        enable = true;
        settings = {
          window = {
            dynamic_padding = true;
            padding.x = 2;
          };
        };
      };
      xdg.configFile = flake.lib.mkMutableFiles [ "alacritty/alacritty.toml" ];
    }

    (mkIf cfg.setAsDefaultTerminal {
      home.sessionVariables.TERMINAL = exe;

      programs.umbriel.settings.keybinds."Mod+Return" = {
        action = "spawn:" + exe;
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
            spawn_when_empty =
              with config.programs;
              "${exe} --class=dropterm -e ${getExe fish.package} -C ${getExe fastfetch.package}";
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

      dconf.settings."com/github/stunkymonkey/nautilus-open-any-terminal".terminal = "alacritty";
    })
  ];
}
