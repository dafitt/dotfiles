{ config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.APPLICATION;
in
{
  options.dafitt.APPLICATION = with types; {
    enable = mkBoolOpt false "Whether to enable APPLICATION.";

    autostart = mkBoolOpt false "Start APPLICATION on login";
    defaultApplication = mkBoolOpt true "Set APPLICATION as the default application for its mimetypes.";
    workspace = mkOpt int 5 "Which workspace is mainly to be used for this application.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ APPLICATION ];
    environment.systemPackages = with pkgs; [ APPLICATION ];

    programs.APPLICATION.enable = true;

    wayland.windowManager.hyprland.settings = {
      exec = [ ];
      exec-once = mkIf cfg.autostart [ "[workspace ${toString cfg.workspace} silent] ${getExe pkgs.APPLICATION}" ];
      binds = [ ];
      windowrule = [ ];
    };
  };
}
