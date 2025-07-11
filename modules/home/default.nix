{ config, lib, pkgs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt;
in
{
  options.dafitt = with types; {
    enableDefaults = mkBoolOpt (osConfig.dafitt.enableDefaults or false) "Whether to enable dafitt defaults.";
  };

  config = mkIf cfg.enableDefaults {
    dafitt = mkDefault {
      browsers.default = "firefox";
      btop.enable = true;
      editors.default = "micro";
      fastfetch.enable = true;
      file-roller.enable = true;
      filemanagers.default = "nautilus";
      flatpak.enable = true;
      imv.enable = true;
      mpv.enable = true;
      passwordManagers.default = "bitwarden";
      personalEnvironment.enable = true;
      starship.enable = true;
      stylix.enable = true;
      suiteWeb.enable = true;
      syncthing.enable = true;
      systemd.enable = true;
      xdg.enable = true;
    };
  };
}
