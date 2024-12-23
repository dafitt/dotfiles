{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.mpv;
in
{
  options.dafitt.mpv = with types; {
    enable = mkBoolOpt true "Whether to enable mpv, a free, open source, and cross-platform media player.";
    defaultApplication = mkBoolOpt true "Set mpv as the default application for its mimetypes";
  };

  config = mkIf cfg.enable {
    # https://mpv.io/
    programs.mpv.enable = true;

    wayland.windowManager.hyprland.settings = {
      windowrulev2 = [
        "idleinhibit focus, class:mpv" #
      ];
    };
  };
}
