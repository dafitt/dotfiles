{ options, config, lib, pkgs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.music;
  osCfg = osConfig.dafitt.music or null;
in
{
  options.dafitt.music = with types; {
    enableSuite = mkBoolOpt (osCfg.enableSuite or false) "Enable the music suite";
  };

  config = mkIf cfg.enableSuite {
    home.packages = with pkgs; [
    ];

    services.flatpak.packages = [
      "io.bassi.Amberol"
      "dev.aunetx.deezer"
    ];
  };
}
