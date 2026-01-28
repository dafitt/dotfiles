{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
{
  home.packages = with pkgs; [
    broot
    clapper
    dua
    duf
    dust
    fd
    gnome-characters
    gnome-text-editor
    libnotify
    localsend
    loupe
    ncdu
    numbat
    ouch
    raider
    ripgrep
    tldr
    wiki-tui
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

    sessionPath = [
      "$HOME/.path"
      "$XDG_DESKTOP_DIR/scripts"
    ];

    sessionVariables = {
      SYSTEMD_LESS = "j.25MqRFSWK#.25";
    };

    shellAliases = {
      # skip an alias with #$ command ...

      # I don't like the default but my hand just types it
      calc = "numbat";
      cat = "bat --style plain --pager never";
      cd = "z";
      compress = "ouch compress";
      df = "duf";
      du = "dust";
      fdisk = "gdisk";
      grep = "rg";
      top = "$TOP";
      tree = "eza --tree";
      uncompress = "ouch decompress";

      # rsync
      rsync-copy = "rsync --archive --progress -zvh";
      rsync-move = "rsync --archive --progress -zvh --remove-source-files";
      rsync-sync = "rsync --archive --update --delete --progress -zvh";
      rsync-update = "rsync --archive --update --progress -zvh";
    };
  };

  # Bookmarks #
  gtk.gtk3.bookmarks = [
    "file://${config.home.homeDirectory}/Sync"
  ];

  programs.yazi.keymap.mgr.append_keymap = [
    {
      on = [
        "g"
        "S"
      ];
      run = "cd ${config.home.homeDirectory}/Sync";
      desc = "Go to ~/Sync";
    }
  ];
}
