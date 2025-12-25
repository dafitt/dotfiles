{
  config,
  lib,
  pkgs,
  osConfig ? { },
  ...
}:
with lib;
let
  cfg = config.dafitt.MODULE;
in
{
  options.dafitt.MODULE = with types; {
    setAsDefault = mkEnableOption "making it the default";

    autostart = mkBoolOpt false "Whether to autostart at user login.";
    workspace = mkOpt int 5 "Which workspace is mainly to be used for this application.";
  };

  config = {
    home.packages = with pkgs; [ MODULE ];

    programs.MODULE.enable = true;

    wayland.windowManager.hyprland.settings = {
      bind = cfg.setAsDefault [ ];
      exec-once = mkIf cfg.autostart [ "[workspace ${toString cfg.workspace} silent] ${pkgs.MODULE}" ];
      windowrule = [ ];
    };
  };
}
