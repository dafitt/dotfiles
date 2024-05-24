{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.desktops.hyprland.plugins;
in
{
  options.dafitt.desktops.hyprland.plugins = with types; {
    enable = mkBoolOpt config.dafitt.desktops.hyprland.enable "Enable plugins for hyprland, which are not set to false by default.";
  };

  config = mkIf cfg.enable { };
}
