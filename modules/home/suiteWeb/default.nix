{ options, config, lib, pkgs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.suiteWeb;
  osCfg = osConfig.dafitt.suiteWeb or null;
in
{
  options.dafitt.suiteWeb = with types; {
    enable = mkBoolOpt (osCfg.enable or true) "Whether to enable the Web suite.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
    ];

    services.flatpak = {
      packages = [
        "de.haeckerfelix.Fragments" # Manage torrents
        "dev.geopjr.Collision" # Check hashes for your files
      ];
      overrides = {
        "dev.geopjr.Collision".Context.filesystems = [ "xdg-download:ro" ];
      };
    };
  };
}
