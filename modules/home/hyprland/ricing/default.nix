{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.hyprland.ricing;
in
{
  options.dafitt.hyprland.ricing = with types; {
    enable = mkEnableOption "some hyprland ricing, at the cost of battery usage";
  };

  config = mkIf cfg.enable {
    dafitt.hyprland.ricing.wallpaper.enable = true;
  };
}
