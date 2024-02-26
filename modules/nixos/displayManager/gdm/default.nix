{ options, config, lib, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.displayManager.gdm;
in
{
  options.custom.displayManager.gdm = with types; {
    enable = mkBoolOpt false "Enable gdm as the login/display manager";
  };

  config = mkIf cfg.enable {
    services.xserver.enable = true;
    services.xserver.displayManager = {
      gdm = {
        enable = true;
        wayland = true;
      };
    };

    programs.dconf.profiles.gdm.databases = [{
      settings = {
        "org/gnome/desktop/peripherals/touchpad".tap-to-click = true;
      };
    }];
  };
}
