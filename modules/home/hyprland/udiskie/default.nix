{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.hyprland.udiskie;
in
{
  options.dafitt.hyprland.udiskie = with types; {
    enable = mkBoolOpt false "Whether to enable the udiskie mount helper.";
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
