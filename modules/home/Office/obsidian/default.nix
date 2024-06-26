{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.Office.obsidian;
in
{
  options.dafitt.Office.obsidian = with types; {
    enable = mkBoolOpt config.dafitt.Office.enableSuite "Enable obsidian.";
  };

  config = mkIf cfg.enable {
    services.flatpak.packages = [
      "md.obsidian.Obsidian"
    ];

    wayland.windowManager.hyprland.settings.exec-once = [
      "[workspace 3 silent;noinitialfocus] ${pkgs.flatpak}/bin/flatpak run md.obsidian.Obsidian"
    ];
  };
}
