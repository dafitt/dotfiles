{
  config,
  lib,
  pkgs,
  osConfig ? { },
  ...
}:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.MODULE;
  osCfg = osConfig.dafitt.MODULE or null;
in
{
  options.dafitt.MODULE = with types; {
    enable = mkBoolOpt (osCfg.enable or false) "Whether to enable MODULE.";
    setAsDefault = mkEnableOption "making it the default";

    autostart = mkBoolOpt false "Whether to autostart at user login.";
    workspace = mkOpt int 5 "Which workspace is mainly to be used for this application.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ MODULE ];

    programs.MODULE.enable = true;

    wayland.windowManager.hyprland.settings = {
      bind = cfg.setAsDefault [ ];
      exec-once = mkIf cfg.autostart [ "[workspace ${toString cfg.workspace} silent] ${pkgs.MODULE}" ];
      windowrule = [ ];
    };
  };
}
