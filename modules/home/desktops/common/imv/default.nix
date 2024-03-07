{ config, lib, options, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.desktops.common.imv;
in
{
  options.custom.desktops.common.imv = with types; {
    enable = mkBoolOpt config.custom.desktops.common.enable "Enable imv terminal image viewer";
  };

  config = mkIf cfg.enable {
    # a command line image viewer for tiling window managers
    # https://sr.ht/~exec64/imv/
    programs.imv = {
      enable = true;
      settings = {
        # https://man.archlinux.org/man/imv.5.en
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
  };
}
