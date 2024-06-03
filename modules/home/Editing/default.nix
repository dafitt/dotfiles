{ options, config, lib, pkgs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.Editing;
  osCfg = osConfig.dafitt.Editing or null;
in
{
  options.dafitt.Editing = with types; {
    enableSuite = mkBoolOpt (osCfg.enableSuite or false) "Enable the Editing suite";
  };

  config = mkIf cfg.enableSuite {
    home.packages = with pkgs; [
      tenacity # Sound editor with graphical UI
    ];

    services.flatpak.packages = [
      "io.gitlab.adhami3310.Footage"
      "org.shotcut.Shotcut"
    ];
  };
}
