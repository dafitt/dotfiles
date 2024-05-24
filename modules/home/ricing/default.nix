{ options, config, lib, pkgs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.ricing;
  osCfg = osConfig.dafitt.ricing or null;
in
{
  options.dafitt.ricing = with types; {
    enableSuite = mkBoolOpt (osCfg.enableSuite or false) "Enable the ricing suite";
  };

  config = mkIf cfg.enableSuite {
    home.packages = with pkgs; [
      asciiquarium # aquarium in your terminal
      cava # console-based Audio Visualizer for Alsa
      cbonsai # grow bonsai trees in your terminal
      cowsay
      fortune
      lolcat
      peaclock # a text-based clock
      pipes # animated pipes terminal screensaver
    ];

    dafitt.desktops.hyprland = mkIf config.dafitt.desktops.hyprland.enable {
      ricing.enable = true;
    };
  };
}
