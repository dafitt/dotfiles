{ config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.zed-editor;
in
{
  options.dafitt.zed-editor = with types; {
    enable = mkEnableOption "zed-editor";

    autostart = mkBoolOpt false "Start zed-editor on login";
    workspace = mkOpt int 2 "Which workspace is mainly to be used for this application.";
  };

  config = mkIf cfg.enable {
    programs.zed-editor = {
      enable = true;
    };

    wayland.windowManager.hyprland.settings = {
      #bind = [ "SUPER_ALT, G, exec, uwsm app -- ${getExe config.programs.zed-editor.package}" ];
      exec-once = mkIf cfg.autostart [ "[workspace ${toString cfg.workspace} silent] uwsm app -- ${getExe config.programs.zed-editor.package}" ];
    };
  };
}
