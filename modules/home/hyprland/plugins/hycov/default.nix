{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.hyprland.plugins.hycov;
in
{
  options.dafitt.hyprland.plugins.hycov = with types; {
    enable = mkEnableOption "hycov (Discontinued!)";
  };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      # https://github.com/DreamMaoMao/hycov
      plugins = [ pkgs.hyprlandPlugins.hycov ];

      settings.bind = [
        "SUPER, tab, hycov:toggleoverview"
        "SUPER, E, hycov:toggleoverview, forceall"
      ];

      extraConfig = ''
        plugin:hycov {
          only_active_monitor = 1

          # alt-mode
          enable_alt_release_exit = 1
          alt_replace_key = Super_L
        }
      '';
    };
  };

  # code traces in:
  # - modules/home/desktops/hyprland/default.nix: bind
}
