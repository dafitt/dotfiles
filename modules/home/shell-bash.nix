{ lib, config, ... }:
with lib;
let
  cfg = config.dafitt.shell-bash;
in
{
  #meta.doc = builtins.toFile "doc.md" ''
  #  Configures GNU Bourne-Again Shell.
  #  <https://www.gnu.org/software/bash/>
  #'';

  options.dafitt.shell-bash = with types; {
    setAsDefaultShell = mkEnableOption "making it the default SHELL";
  };

  config = {
    programs.bash = {
      enable = true;

      historyControl = [
        "erasedups"
        "ignoredups"
        "ignorespace"
      ];
      historyIgnore = [
        "ls"
        "cd"
        "rm"
        "exit"
      ];
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

    home.sessionVariables.SHELL = mkIf cfg.setAsDefaultShell (getExe config.programs.bash.package);
  };
}
