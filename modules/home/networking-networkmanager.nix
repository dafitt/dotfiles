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
      "Super&Alt, N, exec, ${getExe pkgs.pyprland} toggle networkmanager"
    ];
    windowrule = [
      "match:class nm-connection-editor, float on"
    ];
  };
  dafitt.pyprland.scratchpads.networkmanager = {
    animation = "fromRight";
    command = "uwsm app -- ${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
    class = "nm-connection-editor";
    size = "40% 70%";
    margin = "2%";
    lazy = true;
  };
  programs.niri.settings = {
    binds."Mod+Alt+N".action.spawn-sh =
      "uwsm app -- ${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
  };
}
