{
  # a command line image viewer for tiling window managers
  # https://sr.ht/~exec64/imv/
  programs.imv = {
    enable = true;
    settings = {
      # <https://man.archlinux.org/man/imv.5.en>
      aliases = {
        "<Escape>" = "quit";
        "i" = "overlay";

        "<right>" = "next";
        "<left>" = "prev";
        "<space>" = "next";

        "p" = "toggle_playing";
      };
      options = {
        list_files_at_exit = true;
      };
    };
  };
}
