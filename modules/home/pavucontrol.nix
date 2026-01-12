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
      "match:class pavucontrol$, match:title ^Volume Control$, float on"
      "match:class pavucontrol$, match:title ^Volume Control$, center on"
      #"match:class pavucontrol$, match:title ^Volume Control$, size 800 600"
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
