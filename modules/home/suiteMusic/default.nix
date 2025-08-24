{
  config,
  lib,
  pkgs,
  osConfig ? { },
  ...
}:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.suiteMusic;
  osCfg = osConfig.dafitt.suiteMusic or null;
in
{
  options.dafitt.suiteMusic = with types; {
    enable = mkBoolOpt (osCfg.enable or false) "Whether to enable the Music suite.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
    ];

    services.flatpak.packages = [
      "app.drey.EarTag" # Edit audio file tags
      "com.rafaelmardojai.Blanket" # Listen to ambient sounds
      "de.haeckerfelix.Shortwave" # Listen to internet radio
      "dev.aunetx.deezer" # Online music streaming service
      "io.bassi.Amberol" # Plays music, and nothing else
      "io.github.seadve.Mousai" # Identify songs in seconds
    ];
  };
}
