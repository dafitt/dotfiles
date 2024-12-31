{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.browsers.epiphany;
in
{
  options.dafitt.browsers.epiphany = with types; {
    enable = mkEnableOption "epiphany browser";

    autostart = mkBoolOpt true "Whether to autostart at user login.";
    configureKeybindings = mkBoolOpt false "Whether to configure keybindings.";
  };

  config = mkIf cfg.enable {
    # Simple and easy to use web browser
    home.packages = with pkgs; [ epiphany ];

    wayland.windowManager.hyprland.settings = {
      bind = mkIf cfg.configureKeybindings [ "SUPER_ALT, W, exec, ${getExe pkgs.epiphany}" ];
      exec-once = mkIf cfg.autostart [ "[workspace 1 silent] ${getExe pkgs.epiphany}" ];
    };

    # needs inputs.xdg-autostart.homeManagerModules.xdg-autostart
    xdg.autoStart.packages = mkIf cfg.autostart [ pkgs.epiphany ];
  };
}
