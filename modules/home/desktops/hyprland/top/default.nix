{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.desktops.hyprland.top;
in
{
  options.dafitt.desktops.hyprland.top = with types; {
    enable = mkBoolOpt config.dafitt.desktops.hyprland.enable "Enable a top for hyprland";
  };

  config = mkIf cfg.enable {
    programs.btop = {
      enable = true;
      settings = {
        theme_background = false;
      };
    };

    wayland.windowManager.hyprland.settings = {
      bind = [ "SUPER_ALT, P, exec, ${config.home.sessionVariables.TERMINAL} -e ${config.programs.btop.package}/bin/btop" ];
      windowrulev2 = [
        "float, title:^btop$, class:kitty"
        "size 90% 90%, title:^btop$"
        "minsize 800 530, title:^btop$"
        "center, title:^btop$"
      ];
    };
  };
}
