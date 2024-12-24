{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.hyprland.pavucontrol;
in
{
  options.dafitt.hyprland.pavucontrol = with types; {
    enable = mkBoolOpt config.dafitt.hyprland.enable "Whether to enable the pavucontrol, PulseAudio Volume Control.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ pavucontrol ];

    wayland.windowManager.hyprland.settings = {
      bind = optionals config.dafitt.hyprland.pyprland.enable
        [ "SUPER_ALT, A, exec, ${pkgs.pyprland}/bin/pypr toggle pavucontrol" ];
      windowrulev2 = [
        "float, class:pavucontrol, title:^(Volume Control)$"
        "center, class:pavucontrol, title:^(Volume Control)$"
        #"size 800 600, class:pavucontrol, title:^(Volume Control)$"
      ];
    };

    dafitt.hyprland.pyprland.scratchpads.pavucontrol = {
      animation = "fromRight";
      command = "${pkgs.pavucontrol}/bin/pavucontrol";
      class = "pavucontrol";
      size = "40% 70%";
      margin = "2%";
      unfocus = "hide";
      lazy = true;
    };
  };
}
