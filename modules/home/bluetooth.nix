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

  wayland.windowManager.hyprland.settings = {
    bind = optionals config.dafitt.pyprland.enable [
      "Super&Alt, B, exec, ${pkgs.pyprland}/bin/pypr toggle bluetooth"
    ];
    windowrule = [
      "match:class io.github.kaii_lb.Overskride$, float on"
    ];
  };

  dafitt.pyprland.scratchpads.bluetooth = {
    animation = "fromRight";
    command = "uwsm app -- ${pkgs.overskride}/bin/overskride";
    class = "io.github.kaii_lb.Overskride";
    size = "40% 70%";
    margin = "2%";
    lazy = true;
  };
}
