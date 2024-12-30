{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.browsers.epiphany;
  browsersCfg = config.dafitt.browsers;

  isDefault = browsersCfg.default == "epiphany";
in
{
  options.dafitt.browsers.epiphany = with types; {
    enable = mkBoolOpt isDefault "Whether to enable the epiphany Web browser.";
  };

  config = mkIf cfg.enable {
    # Simple and easy to use web browser
    home.packages = with pkgs; [ epiphany ];

    wayland.windowManager.hyprland.settings = mkIf isDefault {
      bind = [ "SUPER_ALT, W, exec, ${getExe pkgs.epiphany}" ];
      exec-once = mkIf browsersCfg.autostart [ "[workspace 1 silent] ${getExe pkgs.epiphany}" ];
    };

    # needs inputs.xdg-autostart.homeManagerModules.xdg-autostart
    xdg.autoStart.packages = mkIf browsersCfg.autostart [ pkgs.epiphany ];
  };
}
