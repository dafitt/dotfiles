{ config, lib, ... }:
with lib;
let
  cfg = config.dafitt.desktopEnvironment-hyprland.plugins;
in
{
  imports = [
    plugins/hypr-darkwindow.nix
    plugins/hypr-dynamic-cursors.nix
    plugins/hyprspace.nix
  ];
}
