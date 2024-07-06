{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.Web.epiphany;
  WebCfg = config.dafitt.Web;

  isDefault = WebCfg.default == "epiphany";
in
{
  options.dafitt.Web.epiphany = with types; {
    enable = mkBoolOpt (config.dafitt.Web.enableSuite || isDefault) "Enable the epiphany Web browser.";
  };

  config = mkIf cfg.enable {
    # Simple and easy to use web browser
    home.packages = with pkgs; [ epiphany ];

    wayland.windowManager.hyprland.settings = mkIf isDefault {
      bind = [ "SUPER_ALT, W, exec, ${getExe pkgs.epiphany}" ];
      exec-once = mkIf WebCfg.autostart [ "[workspace 1 silent] ${getExe pkgs.epiphany}" ];
    };
  };
}
