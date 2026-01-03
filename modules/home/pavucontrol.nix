{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib;
{
  imports = with inputs; [
    self.homeModules.pyprland
  ];

  home.packages = with pkgs; [ pavucontrol ];

  wayland.windowManager.hyprland.settings = {
    bind = optionals config.dafitt.pyprland.enable [
      "Super&Alt, A, exec, ${pkgs.pyprland}/bin/pypr toggle pavucontrol"
    ];
    windowrule = [
      "float, class:pavucontrol, title:^(Volume Control)$"
      "center, class:pavucontrol, title:^(Volume Control)$"
      #"size 800 600, class:pavucontrol, title:^(Volume Control)$"
    ];
  };

  dafitt.pyprland.scratchpads.pavucontrol = {
    animation = "fromRight";
    command = "uwsm app -- ${pkgs.pavucontrol}/bin/pavucontrol";
    class = "pavucontrol";
    size = "40% 70%";
    margin = "2%";
    unfocus = "hide";
    lazy = true;
  };
}
