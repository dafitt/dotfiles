{ pkgs, ... }: {

  # various command line programs
  home.packages = with pkgs; [

    # tools
    broot # an interactive tree view with fuzzy search, balanced BFS descent and customizable commands
    calc # a calculator
    dig # tool for DNS
    duf # a better 'df'
    httpie
    hyprpicker # color picker
    ncdu # disk usage analyzer with an ncurses interface
    nvme-cli # tool for nvme interface
    tldr # simplified and community-driven man pages
    tree
    wev # tool for keyboard input
    xorg.xrandr # tool for screens/monitors

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

    ssh = {
      enable = true;
    };
  };
}
