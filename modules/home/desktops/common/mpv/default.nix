{ config, lib, options, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.desktops.common.mpv;
in
{
  options.custom.desktops.common.mpv = with types; {
    enable = mkBoolOpt config.custom.desktops.common.enable "Enable mpv, a free, open source, and cross-platform media player";
  };

  config = mkIf cfg.enable {
    # https://mpv.io/
    programs.mpv = {
      enable = true;
      #defaultProfiles = [ "gpu-hq" ];
      #scripts = [ pkgs.mpvScripts.mpris ];
    };

    wayland.windowManager.hyprland.settings = {
      windowrulev2 = [
        "idleinhibit focus, class:mpv" #
      ];
    };
  };
}
