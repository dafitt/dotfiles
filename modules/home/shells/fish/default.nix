{ options, config, lib, pkgs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.shells.fish;
  osCfg = osConfig.dafitt.shells.fish or null;
in
{
  options.dafitt.shells.fish = with types; {
    enable = mkBoolOpt (osCfg.enable or false) "Whether to enable the fish shell.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      fzf
      grc
    ];

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

      # https://github.com/jorgebucaran/awsm.fish#readme
      # https://search.nixos.org/packages?query=fishPlugins
      plugins = map (n: { name = n; src = pkgs.fishPlugins.${n}.src; }) [
        "autopair" # https://github.com/jorgebucaran/autopair.fish
        "bass" # https://github.com/edc/bass
        "done" # https://github.com/franciscolourenco/done
        "fzf" # https://github.com/jethrokuan/fzf
        "grc"
        "puffer" # https://github.com/nickeb96/puffer-fish
        "sponge" # https://github.com/meaningful-ooo/sponge
      ];
    };

    home.sessionVariables = {
      FZF_COMPLETE = "2";
      FZF_LEGACY_KEYBINDINGS = "0";
    };
  };
}
