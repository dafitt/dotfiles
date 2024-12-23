{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.environment;
in
{
  options.dafitt.environment = with types; {
    enable = mkBoolOpt true "Whether to enable my personal (shell) environment (programs/services/variables).";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      broot # an interactive tree view with fuzzy search, balanced BFS descent and customizable commands
      calc # a calculator
      clapper # a simple and modern GNOME media player
      duf # a better 'df'
      gnome-characters # character picker
      libnotify # sends desktop notifications to a notification daemon
      localsend # open source cross-platform alternative to AirDrop
      ncdu # disk usage analyzer with an ncurses interface
      raider # file shredder
      tldr # simplified and community-driven man pages
      tree # a directory listing program
      xfce.thunar # for the bulk renamer
    ];

    programs = {
      bat.enable = true;
      eza = {
        enable = true;
        icons = "auto";
        git = true;
      };
      fzf = {
        enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;
      };
      hstr.enable = true;
      lsd = {
        enable = true;
        enableAliases = true; # ls, ll, la, lt ...
      };
    };

    home = {
      language.base = "en_US.UTF-8";

      sessionPath = [ "$HOME/Desktop/binaries" ];

      shellAliases = {
        # skip an alias with #$ command ...

        # I don't like the default but my hand just types it
        top = "$TOP";
        cat = "bat --paging=never";
        df = "duf";
        du = "ncdu -r -x";
        tree = "eza -T";
        fdisk = "gdisk";

        # Navigation;
        ".." = "cd ..";
        "..." = "cd ../..";
        "...." = "cd ../../..";
        "....." = "cd ../../../..";

        # systemd
        systemctl = "systemctl --no-pager --full";

        # Colors
        grep = "grep --color=auto";

        # rsync
        rsync-copy = "rsync --archive --progress -zvh";
        rsync-move = "rsync --archive --progress -zvh --remove-source-files";
        rsync-sync = "rsync --archive --update --delete --progress -zvh";
        rsync-update = "rsync --archive --update --progress -zvh";
      };
    };
  };
}
