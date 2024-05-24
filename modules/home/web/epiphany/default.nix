{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.web.epiphany;
  webCfg = config.dafitt.web;

  isDefault = webCfg.default == "epiphany";
in
{
  options.dafitt.web.epiphany = with types; {
    enable = mkBoolOpt (config.dafitt.web.enableSuite || isDefault) "Enable the epiphany web browser.";
  };

  config = mkIf cfg.enable {
    # Simple and easy to use web browser
    home.packages = with pkgs; [ epiphany ];

    wayland.windowManager.hyprland.settings = mkIf isDefault {
      bind = [ "SUPER_ALT, B, exec, ${getExe pkgs.epiphany}" ];
      exec-once = mkIf webCfg.autostart [ "[workspace 1 silent] ${getExe pkgs.epiphany}" ];
    };
  };
}
