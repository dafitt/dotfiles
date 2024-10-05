{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.desktops.hyprland.udiskie;
in
{
  options.dafitt.desktops.hyprland.udiskie = with types; {
    enable = mkBoolOpt config.dafitt.desktops.hyprland.enable "Enable the udiskie mount helper.";
  };

  config = mkIf cfg.enable {
    services.udiskie = {
      enable = true;
      notify = false;
      settings = {
        icon_names.media = [ "media-optical" ];
      };
    };
  };
}
