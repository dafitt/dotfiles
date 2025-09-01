{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.xdg;
in
{
  options.dafitt.xdg = with types; {
    enable = mkEnableOption "basic xdg settings";
  };

  config = mkIf cfg.enable {
    xdg = {
      enable = true;
      cacheHome = "${config.home.homeDirectory}/.local/cache";
      userDirs = {
        enable = true;
        createDirectories = true;
        extraConfig = {
          XDG_BIN_HOME = "${config.home.homeDirectory}/.local/bin";
          XDG_SECRET_HOME = "${config.home.homeDirectory}/.local/secrets";

          # Make some programs "XDG" compliant.
          LESSHISTFILE = "${config.xdg.cacheHome}/less.history";
          WGETRC = "${config.xdg.cacheHome}/wgetrc";
        };
      };
    };

    gtk.gtk3.bookmarks = with config.xdg.userDirs; [
      "file://${desktop}"
      "file://${documents}"
      "file://${download}"
      "file://${music}"
      "file://${pictures}"
      "file://${templates}"
      "file://${videos}"
    ];

    programs.yazi.keymap.mgr.append_keymap = with config.xdg.userDirs; [
      {
        on = [
          "g"
          "s"
        ];
        run = "cd ${desktop}";
        desc = "Go to ~/Desktop";
      }
      {
        on = [
          "g"
          "f"
        ];
        run = "cd ${documents}";
        desc = "Go to ~/Documents";
      }
      {
        on = [
          "g"
          "s"
        ];
        run = "cd ${download}";
        desc = "Go to ~/Downloads";
      }
      {
        on = [
          "g"
          "m"
        ];
        run = "cd ${music}";
        desc = "Go to ~/Music";
      }
      {
        on = [
          "g"
          "p"
        ];
        run = "cd ${pictures}";
        desc = "Go to ~/Pictures";
      }
      {
        on = [
          "g"
          "t"
        ];
        run = "cd ${templates}";
        desc = "Go to ~/Templates";
      }
      {
        on = [
          "g"
          "v"
        ];
        run = "cd ${videos}";
        desc = "Go to ~/Videos";
      }
    ];
  };
}
