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
      "SUPER_ALT, N, exec, ${getExe pkgs.pyprland} toggle connman"
    ];
    windowrule = [ "float, class:connman-gtk" ];
  };
  dafitt.pyprland.scratchpads.connman = {
    animation = "fromRight";
    command = "uwsm app -- ${pkgs.connman-gtk}/bin/connman-gtk";
    class = "connman-gtk";
    size = "40% 70%";
    margin = "2%";
    lazy = true;
  };
  programs.niri.settings = {
    binds."Mod+Alt+N".action.spawn-sh = "uwsm app -- ${pkgs.connman-gtk}/bin/connman-gtk";
  };
}
