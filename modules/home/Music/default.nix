{ options, config, lib, pkgs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.Music;
  osCfg = osConfig.dafitt.Music or null;
in
{
  options.dafitt.Music = with types; {
    enableSuite = mkBoolOpt (osCfg.enableSuite or false) "Enable the Music suite.";
  };

  config = mkIf cfg.enableSuite {
    home.packages = with pkgs; [
    ];

    services.flatpak.packages = [
      "com.rafaelmardojai.Blanket" # Listen to ambient sounds
      "de.haeckerfelix.Shortwave" # Listen to internet radio
      "dev.aunetx.deezer" # Online music streaming service
      "io.bassi.Amberol" # Plays music, and nothing else
      "io.github.seadve.Mousai" # Identify songs in seconds
    ];
  };
}
