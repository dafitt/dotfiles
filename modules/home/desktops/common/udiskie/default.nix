{ config, lib, options, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.desktops.common.udiskie;
in
{
  options.custom.desktops.common.udiskie = with types; {
    enable = mkBoolOpt config.custom.desktops.common.enable "Enable the udiskie mount helper";
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
