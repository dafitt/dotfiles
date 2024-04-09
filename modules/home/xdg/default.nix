{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.xdg;
in
{
  options.dafitt.xdg = with types; {
    enable = mkBoolOpt true "Set up basic xdg settings";
  };

  config = mkIf cfg.enable {
    xdg = {
      enable = true;
      cacheHome = "${config.home.homeDirectory}/.local/cache";
      userDirs = {
        enable = true;
        createDirectories = true;
        extraConfig = {
          XDG_SECRETS_DIR = "${config.home.homeDirectory}/.secrets";
        };
      };
    };
  };
}
