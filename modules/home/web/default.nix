{ options, config, lib, pkgs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.web;
  osCfg = osConfig.dafitt.web or null;
in
{
  options.dafitt.web = with types; {
    enableSuite = mkBoolOpt (osCfg.enableSuite or true) "Enable the web suite";

    default = mkOpt (nullOr (enum [ "epiphany" "firefox" "librewolf" ])) "firefox" "Which web browser is to be used primarily";
    autostart = mkBoolOpt true "Start the web browser on login";
  };

  config = mkIf cfg.enableSuite {
    home.packages = with pkgs; [
    ];

    services.flatpak = {
      packages = [
        { appId = "dev.geopjr.Collision"; origin = "flathub"; } # Hash checker for your files
      ];
      overrides = {
        "dev.geopjr.Collision".Context.filesystems = [ "xdg-download:ro" ];
      };
    };
  };
}
