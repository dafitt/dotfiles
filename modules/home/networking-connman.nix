{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib;
{
  #meta.doc = builtins.toFile "doc.md" "Adds Connman network control.";

  imports = with inputs; [
    self.homeModules.pyprland
  ];

  wayland.windowManager.hyprland.settings = {
    bind = optionals config.dafitt.pyprland.enable [
      "Super&Alt, N, exec, ${getExe pkgs.pyprland} toggle connman"
    ];
    windowrule = [
      "match:class connman-gtk, float on"
    ];
  };
  dafitt.pyprland.scratchpads.connman = {
    animation = "fromRight";
    command = "uwsm app -- ${pkgs.connman-gtk}/bin/connman-gtk";
    class = "connman-gtk";
    size = "40% 70%";
    margin = config.wayland.windowManager.hyprland.settings.general.gaps_out or 0;
    lazy = true;
  };
  programs.niri.settings = {
    binds."Mod+Alt+N".action.spawn-sh = "uwsm app -- ${pkgs.connman-gtk}/bin/connman-gtk";
  };
}
