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
  cfg = config.dafitt.suiteEditing;
  osCfg = osConfig.dafitt.suiteEditing or null;
in
{
  options.dafitt.suiteEditing = with types; {
    enable = mkBoolOpt (osCfg.enable or false) "Whether to enable the Editing suite.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      tenacity # Sound editor with graphical UI
    ];

    services.flatpak.packages = [
      "com.github.huluti.Curtail" # Compress your images
      "fr.romainvigier.MetadataCleaner" # View and clean metadata in files
      "io.gitlab.adhami3310.Footage" # Polish your videos
      "org.gnome.gitlab.YaLTeR.Identity" # Compare images and videos
      "org.shotcut.Shotcut" # Video editor
    ];
  };
}
