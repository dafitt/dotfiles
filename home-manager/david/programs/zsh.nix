{ config, lib, pkgs, ... }: {

  # The Z shell
  # https://www.zsh.org/
  programs.zsh = {
    enable = false;
    autocd = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    history = {
      expireDuplicatesFirst = true;
      ignoreAllDups = true;
      ignorePatterns = [ "ls" "cd" "rm" "exit" ];
      ignoreSpace = true;
    };
    historySubstringSearch.enable = true;
    shellAliases = import ../common/shellAliases.nix;
    syntaxHighlighting.enable = true;

    initExtra = ''
      bindkey '^H' backward-kill-word
      bindkey '^[[3;3~' kill-word
      bindkey '^[[3;5~' kill-word
      bindkey '^[[1;5D' backward-word
      bindkey '^[[1;5C' forward-word
    '';

    loginExtra = lib.mkMerge [
      "${pkgs.neofetch}/bin/neofetch"

      # Autostart Hyprland
      #''if [ "$(tty)" = "/dev/tty1" ]; then exec Hyprland; fi''
    ];
  };

  home.sessionVariables = {
    PROMPT_EOL_MARK = ""; # remove the output of '%'
  };
}
