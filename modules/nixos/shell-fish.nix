{ pkgs, ... }:
{
  #meta.doc = builtins.toFile "doc.md" ''
  #  Installs and configures a friendly interactive shell to your system.

  #  <https://fishshell.com/>
  #'';

  programs.fish.enable = true;

  # https://wiki.nixos.org/wiki/Fish#Setting_fish_as_your_shell
  programs.bash = {
    interactiveShellInit = ''
      # "check if parent process is not fish" && "make nested shells work properly"
      if grep -qv fish /proc/$PPID/comm && [[ $SHLVL == [12] ]]; then
          # set $SHELL for better integration with programs like nix shell, tmux, etc.
          SHELL=${pkgs.fish}/bin/fish exec fish
      fi
    '';
  };
}
