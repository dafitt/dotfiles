{ pkgs, ... }: {

  # various command line programs
  home.packages = with pkgs; [

    # tools
    broot # an interactive tree view with fuzzy search, balanced BFS descent and customizable commands
    borgbackup # deduplicating backup program
    calc # a calculator
    dig # tool for DNS
    duf # a better 'df'
    gptfdisk # tool for GPT partition tables
    hdparm # tool for SATA/ATA devices
    httpie # a modern command line HTTP client
    hyprpicker # color picker
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
