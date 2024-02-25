{ options, config, lib, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.features.displayManager.gdm;
in
{
  options.features.displayManager.gdm = with types; {
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
