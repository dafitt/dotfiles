{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.Office.scribus;
in
{
  options.dafitt.Office.scribus = with types; {
    enable = mkBoolOpt config.dafitt.Office.enableSuite "Whether to enable scribus.";
  };

  config = mkIf cfg.enable {
    # Desktop Publishing (DTP) and Layout program for Linux
    home.packages = with pkgs; [ scribus ];

    wayland.windowManager.hyprland.settings.windowrulev2 = [
      "float, class:scribus, title:(New Document)"
    ];
  };
}
