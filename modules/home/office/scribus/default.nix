{ options, config, lib, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.office.scribus;
in
{
  options.custom.office.scribus = with types; {
    enable = mkBoolOpt config.custom.office.enableSuite "Enable scribus";
  };

  config = mkIf cfg.enable {
    # Desktop Publishing (DTP) and Layout program for Linux
    home.packages = with pkgs; [ scribus ];

    wayland.windowManager.hyprland.settings = {
      bind = [ ];
      exec-once = [ ];
      exec = [ ];
      windowrulev2 = [
        "float, class:scribus, title:(New Document)"
      ];
    };
  };
}
