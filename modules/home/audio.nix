{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib;
{
  #meta.doc = builtins.toFile "doc.md" "Installs and configures pavucontrol audio control.";

  imports = with inputs; [
    self.homeModules.pyprland
  ];

  home.packages = with pkgs; [ pavucontrol ];

  wayland.windowManager.hyprland.settings = {
    bind = optionals config.dafitt.pyprland.enable [
      "Super&Alt, A, exec, ${pkgs.pyprland}/bin/pypr toggle audio"
    ];
    windowrule = [
      "match:class pavucontrol$, match:title ^Volume Control$, float on"
    ];
  };

  dafitt.pyprland.scratchpads.audio = {
    animation = "fromLeft";
    command = "uwsm app -- ${getExe pkgs.pavucontrol}";
    class = "org.pulseaudio.pavucontrol";
    size = "40% 70%";
    lazy = true;
  };
}
