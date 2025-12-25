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
      "SUPER_ALT, N, exec, ${pkgs.pyprland}/bin/pypr toggle networkmanager"
    ];
    windowrule = [ "float, class:nm-connection-editor" ];
  };

  dafitt.pyprland.scratchpads.networkmanager = {
    animation = "fromRight";
    command = "uwsm app -- ${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
    class = "nm-connection-editor";
    size = "40% 70%";
    margin = "2%";
    lazy = true;
  };
}
