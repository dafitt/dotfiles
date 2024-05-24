{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.desktops.hyprland.ricing;
in
{
  options.dafitt.desktops.hyprland.ricing = with types; {
    enable = mkBoolOpt false "Enable some hyprland ricing, at the cost of battery usage";
  };

  config = mkIf cfg.enable { };
}
