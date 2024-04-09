{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.desktops.common.udiskie;
in
{
  options.dafitt.desktops.common.udiskie = with types; {
    enable = mkBoolOpt config.dafitt.desktops.common.enable "Enable the udiskie mount helper";
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
