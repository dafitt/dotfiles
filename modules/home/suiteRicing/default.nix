{ options, config, lib, pkgs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.suiteRicing;
  osCfg = osConfig.dafitt.suiteRicing or null;
in
{
  options.dafitt.suiteRicing = with types; {
    enable = mkBoolOpt (osCfg.enable or false) "Whether to enable the Ricing suite.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      asciiquarium # aquarium in your terminal
      cbonsai # grow bonsai trees in your terminal
      cowsay
      fortune
      lolcat
      peaclock # a text-based clock
      pipes # animated pipes terminal screensaver
    ];

    dafitt.hyprland.ricing.enable = mkIf config.dafitt.hyprland.enable true;
  };
}
