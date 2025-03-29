{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.mpv;
in
{
  options.dafitt.mpv = with types; {
    enable = mkEnableOption "mpv, a free, open source, and cross-platform media player";
  };

  config = mkIf cfg.enable {
    # https://mpv.io/
    programs.mpv.enable = true;

    wayland.windowManager.hyprland.settings = {
      windowrule = [
        "idleinhibit focus, class:mpv" #
      ];
    };
  };
}
