{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.office.obsidian;
in
{
  options.dafitt.office.obsidian = with types; {
    enable = mkBoolOpt config.dafitt.office.enableSuite "Enable obsidian";
  };

  config = mkIf cfg.enable {
    services.flatpak.packages = [
      { appId = "md.obsidian.Obsidian"; origin = "flathub"; }
    ];

    wayland.windowManager.hyprland.settings.exec-once = [
      "[workspace 3 silent;noinitialfocus] ${pkgs.flatpak}/bin/flatpak run md.obsidian.Obsidian"
    ];
  };
}
