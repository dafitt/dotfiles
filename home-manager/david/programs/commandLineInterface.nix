{ pkgs, ... }: {

  # Various command line programs
  home.packages = with pkgs; [

    # tools
    borgbackup # deduplicating backup program
    broot # an interactive tree view with fuzzy search, balanced BFS descent and customizable commands
    calc # a calculator
    dig # tool for DNS
    duf # a better 'df'
    httpie # a modern command line HTTP client
    hyprpicker # color picker
    mtr # better traceroute
    ncdu # disk usage analyzer with an ncurses interface
    nvme-cli # tool for nvme interface
    tldr # simplified and community-driven man pages
    tree # a directory listing program
    wev # tool for keyboard input

    # unix porn
    asciiquarium # aquarium in your terminal
    cbonsai # grow bonsai trees in your terminal
    neofetch
    pipes # animated pipes terminal screensaver
  ];

  programs = {
    bat = {
      # cat
      enable = true;
    };

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

      # ls, ll, la, lt ...
      enableAliases = true;
    };
  };
}
