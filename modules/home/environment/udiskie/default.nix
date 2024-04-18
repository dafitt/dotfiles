{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.environment.udiskie;
in
{
  options.dafitt.environment.udiskie = with types; {
    enable = mkBoolOpt config.dafitt.environment.enable "Enable the udiskie mount helper";
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
