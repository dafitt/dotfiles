{ options, config, lib, pkgs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.editing;
  osCfg = osConfig.dafitt.editing or null;
in
{
  options.dafitt.editing = with types; {
    enableSuite = mkBoolOpt (osCfg.enableSuite or false) "Enable the editing suite";
    installExtraPackages = mkBoolOpt cfg.enableSuite "Install extra editing packages";
  };

  config = mkIf cfg.installExtraPackages {
    home.packages = with pkgs; [
      tenacity # Sound editor with graphical UI
    ];

    services.flatpak.packages = [
      "io.gitlab.adhami3310.Footage"
      "org.shotcut.Shotcut"
    ];
  };
}
