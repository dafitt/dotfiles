{ options, config, lib, pkgs, osConfig ? { }, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.shells.fish;
  osCfg = osConfig.custom.shells.fish or null;
in
{
  options.custom.shells.fish = with types; {
    enable = mkBoolOpt (osCfg.enable or false) "Enable the fish shell";
  };

  config = mkIf cfg.enable {
    # The friendly interactive shell
    # https://fishshell.com/
    # https://github.com/fish-shell/fish-shell
    programs.fish = {
      enable = true;

      shellInit = lib.mkMerge [
        # [Default keybindings](https://github.com/fish-shell/fish-shell/blob/master/share/functions/fish_default_key_bindings.fish)
        #$ fish_key_reader
        ''
          bind \cH backward-kill-word
          bind \e\[3\;5~ kill-word
          bind \e\[3\;3~ kill-word
          bind \b backward-kill-path-component
        ''
      ];

      functions = {

        # Disable greeting
        fish_greeting = "";

        # Merge history upon doing up-or-search
        # This lets multiple fish instances share history
        up-or-search = ''
          if commandline --search-mode
            commandline -f history-search-backward
            return
          end
          if commandline --paging-mode
            commandline -f up-line
            return
          end

          set -l lineno (commandline -L)
          switch $lineno
          case 1
            commandline -f history-search-backward
            history merge
          case '*'
            commandline -f up-line
          end
        '';
      };
    };
  };
}
