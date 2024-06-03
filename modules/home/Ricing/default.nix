{ options, config, lib, pkgs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.Ricing;
  osCfg = osConfig.dafitt.Ricing or null;
in
{
  options.dafitt.Ricing = with types; {
    enableSuite = mkBoolOpt (osCfg.enableSuite or false) "Enable the Ricing suite";
  };

  config = mkIf cfg.enableSuite {
    home.packages = with pkgs; [
      asciiquarium # aquarium in your terminal
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
