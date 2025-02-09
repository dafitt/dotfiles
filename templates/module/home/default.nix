{ options, config, lib, pkgs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.MODULE;
  osCfg = osConfig.dafitt.MODULE or null;
in
{
  options.dafitt.MODULE = with types; {
    enable = mkBoolOpt (osCfg.enable or false) "Whether to enable MODULE.";
    #enable = mkEnableOption "MODULE";

    autostart = mkBoolOpt false "Whether to autostart at user login.";
    configureKeybindings = mkBoolOpt false "Whether to configure keybindings.";
    workspace = mkOpt int 5 "Which workspace is mainly to be used for this application.";
  };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland.settings = {
      bind = mkIf cfg.configureKeybindings [ ];
      exec-once = mkIf cfg.autostart [ "[workspace ${toString cfg.workspace} silent] ${pkgs.MODULE}" ];
      windowrulev2 = [ ];
    };
  };
}
