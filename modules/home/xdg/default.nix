{ options, config, lib, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.xdg;
in
{
  options.custom.xdg = with types; {
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
          XDG_SCREENSHOTS_DIR = "${config.xdg.userDirs.pictures}/Screenshots";
          XDG_SECRETS_DIR = "${config.home.homeDirectory}/.secrets";
        };
      };
    };
  };
}
