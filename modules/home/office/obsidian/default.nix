{ options, config, lib, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.office.obsidian;
in
{
  options.custom.office.obsidian = with types; {
    enable = mkBoolOpt config.custom.office.enableSuite "Enable obsidian";
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
