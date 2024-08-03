{ options, config, lib, pkgs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.Web;
  osCfg = osConfig.dafitt.Web or null;
in
{
  options.dafitt.Web = with types; {
    enableSuite = mkBoolOpt (osCfg.enableSuite or true) "Enable the Web suite";

    default = mkOpt (nullOr (enum [ "epiphany" "firefox" "librewolf" ])) "firefox" "Which web browser is to be used primarily";
    autostart = mkBoolOpt true "Start the web browser on login";
  };

  config = mkIf cfg.enableSuite {
    home.packages = with pkgs; [
    ];

    services.flatpak = {
      packages = [
        "dev.geopjr.Collision" # Hash checker for your files.
        "de.haeckerfelix.Fragments" # An easy to use BitTorrent client.
      ];
      overrides = {
        "dev.geopjr.Collision".Context.filesystems = [ "xdg-download:ro" ];
      };
    };
  };
}
