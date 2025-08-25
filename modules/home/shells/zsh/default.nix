{
  config,
  lib,
  pkgs,
  osConfig ? { },
  ...
}:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.zsh;
  osCfg = osConfig.dafitt.zsh or null;
in
{
  options.dafitt.zsh = with types; {
    enable = mkBoolOpt (osCfg.enable or false) "Whether to enable zsh shell.";
  };

  config = mkIf cfg.enable {
    # The Z shell
    # https://www.zsh.org/
    programs.zsh = {
      enable = true;
      autocd = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      history = {
        expireDuplicatesFirst = true;
        ignoreAllDups = true;
        ignorePatterns = [
          "ls"
          "cd"
          "rm"
          "exit"
        ];
        ignoreSpace = true;
      };
      historySubstringSearch.enable = true;
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
      ];
    };

    home.sessionVariables = {
      PROMPT_EOL_MARK = ""; # dont print '%'
    };
  };
}
