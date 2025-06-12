{ config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.personalEnvironment;
in
{
  options.dafitt.personalEnvironment = with types; {
    enable = mkEnableOption "my personal basic (shell) environment with random programs/services/variables";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      broot # interactive tree view with fuzzy search, balanced BFS descent and customizable commands
      calc
      clapper # simple and modern GNOME media player
      dua # interactive `du`
      duf # better `df`
      dust # better `du`
      fd # better `find`
      gitui
      gnome-characters # character picker
      gnome-text-editor
      hyperfine # benchmarking tool
      libnotify # sends desktop notifications to a notification daemon
      localsend # open source cross-platform alternative to AirDrop
      loupe # image viewer
      ncdu # disk usage analyzer with an ncurses interface
      numbat # high precision scientific calculator with full support for physical units
      raider # file shredder
      ripgrep # better `grep`
      tldr # simplified and community-driven man pages
      tokei # lines of code counter
      xfce.thunar # for the bulk renamer
      wiki-tui # wikipedia in a terminal
    ];

    services.flatpak.packages = [
      { origin = "flathub"; appId = "com.usebottles.bottles"; } # Run Windows software on Linux
    ];

    programs = {
      bat.enable = true; # better `cat`
      eza = {
        enable = true; # better `ls`
        icons = "auto";
        git = true;
      };
      fzf = {
        enable = true; # fuzzy finder
        enableBashIntegration = true;
        enableZshIntegration = true;
      };
      hstr.enable = true; # history search
      zoxide.enable = true; # better `cd`
    };

    home = {
      language.base = "en_US.UTF-8";

      sessionPath = [ "$HOME/.path" ];

      sessionVariables = {
        SYSTEMD_LESS = "j.25MqRFSWK#.25";
      };

      shellAliases = {
        # skip an alias with #$ command ...

        # I don't like the default but my hand just types it
        top = "$TOP";
        cat = "bat --pager='less -qRFM'";
        df = "duf";
        tree = "eza -T";
        fdisk = "gdisk";
        du = "dust";
        grep = "rg";
        cd = "z";

        # Navigation;
        ".." = "cd ..";
        "..." = "cd ../..";

        # rsync
        rsync-copy = "rsync --archive --progress -zvh";
        rsync-move = "rsync --archive --progress -zvh --remove-source-files";
        rsync-sync = "rsync --archive --update --delete --progress -zvh";
        rsync-update = "rsync --archive --update --progress -zvh";
      };
    };
  };
}
