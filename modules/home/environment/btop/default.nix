{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.environment.btop;
in
{
  options.dafitt.environment.btop = with types; {
    enable = mkBoolOpt config.dafitt.environment.enable "Enable a btop.";
  };

  config = mkIf cfg.enable {
    programs.btop = {
      enable = true;
      settings = {
        # https://github.com/aristocratos/btop#configurability
        theme_background = false;
        presets = concatStringsSep " " [
          "cpu:0:default"
          "mem:0:default"
          "net:0:default"
          "proc:0:default"
        ]; # for ricing
      };
    };

    wayland.windowManager.hyprland.settings = {
      bind = [ "SUPER_ALT, P, exec, ${config.home.sessionVariables.TERMINAL} -e ${config.programs.btop.package}/bin/btop" ];
      windowrulev2 = [
        "float, title:^btop$, class:kitty" #TODO move to a scratchapd
        "size 90% 90%, title:^btop$"
        "minsize 800 530, title:^btop$"
        "center, title:^btop$"
      ];
    };
  };
}
