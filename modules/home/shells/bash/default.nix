{ options, config, lib, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.shells.bash;
in
{
  options.custom.shells.bash = with types; {
    enable = mkBoolOpt false "Enable bourne-again shell's configuration";
  };

  config = mkIf cfg.enable {
    # GNU Bourne-Again Shell, the de facto standard shell on Linux
    # https://www.gnu.org/software/bash/
    programs.bash = {
      enable = true;

      historyControl = [ "erasedups" "ignoredups" "ignorespace" ];
      historyIgnore = [ "ls" "cd" "rm" "exit" ];
      shellOptions = [
        "autocd"

        # Append to history file rather than replacing it.
        "histappend"

        # check the window size after each command and, if
        # necessary, update the values of LINES and COLUMNS.
        "checkwinsize"

        # Extended globbing.
        "extglob"
        "globstar"

        # Warn if closing shell with running jobs.
        "checkjobs"

        # save multi-line commands as single entries
        "cmdhist"
      ];

      initExtra = ''
        stty werase \^H
      '';
    };
  };
}
