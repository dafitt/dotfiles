{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.environment.xdg;
in
{
  options.dafitt.environment.xdg = with types; {
    enable = mkBoolOpt true "Whether or not to set up basic xdg settings.";
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
          XDG_SECRETS_DIR = "${config.home.homeDirectory}/.secrets";

          # Make some programs "XDG" compliant.
          LESSHISTFILE = "${config.xdg.cacheHome}/less.history";
          WGETRC = "${config.xdg.cacheHome}/wgetrc";
        };
      };
    };
  };
}
