{ options, config, lib, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.desktops.common;
in
{
  options.custom.desktops.common = with types; {
    enable = mkBoolOpt true "Enable my very common desktop environment (tools/programs/services)";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      broot # an interactive tree view with fuzzy search, balanced BFS descent and customizable commands
      calc # a calculator
      clapper # a simple and modern GNOME media player
      duf # a better 'df'
      gnome.file-roller # archive manager
      gnome.gnome-characters # character picker
      ncdu # disk usage analyzer with an ncurses interface
      neofetch # quick system information tool
      pika-backup # Simple backups based on borg
      raider # file shredder
      tldr # simplified and community-driven man pages
      tree # a directory listing program
      xfce.thunar # for the bulk renamer
    ];

    programs = {
      bat.enable = true;
      eza = {
        enable = true;
        icons = true;
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

      sessionVariables = {
        # Default programs
        BROWSER = "${config.programs.librewolf.package}/bin/librewolf";
        EDITOR = "${pkgs.micro}/bin/micro";
        GDITOR = "${pkgs.vscode}/bin/code";
        TERMINAL = "${config.programs.kitty.package}/bin/kitty";
        TOP = "${config.programs.btop.package}/bin/btop"; # preferred system monitor
      };

      shellAliases = {
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