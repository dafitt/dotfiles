{ pkgs, ... }: {

  # The friendly interactive shell
  # https://fishshell.com/
  programs.fish = {
    enable = true;

    shellAliases = import ../common/shellAliases.nix;

    interactiveShellInit = ''

      # kitty integration
      set --global KITTY_INSTALLATION_DIR "${pkgs.kitty}/lib/kitty"
      set --global KITTY_SHELL_INTEGRATION enabled
      source "$KITTY_INSTALLATION_DIR/shell-integration/fish/vendor_conf.d/kitty-shell-integration.fish"
      set --prepend fish_complete_path "$KITTY_INSTALLATION_DIR/shell-integration/fish/vendor_completions.d"
    '';

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
}
