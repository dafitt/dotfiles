{ options, config, lib, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.btop;
in
{
  options.custom.btop = with types; {
    enable = mkBoolOpt true "Enable btop";
  };

  config = mkIf cfg.enable {
    programs.btop = {
      enable = true;
      settings = {
        theme_background = false;
      };
    };

    wayland.windowManager.hyprland.settings = {
      windowrulev2 = [
        "float, title:^btop$, class:kitty"
        "size 90% 90%, title:^btop$"
        "minsize 800 530, title:^btop$"
        "center, title:^btop$"
      ];
    };
  };
}
