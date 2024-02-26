{ options, config, lib, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.features.flatpak;
in
{
  options.custom.features.flatpak = with types; {
    enable = mkBoolOpt false "Enable flatpak support";
  };

  config = mkIf cfg.enable {
    services.flatpak.enable = true;

    xdg.portal = {
      enable = true;
      config.common.default = [ "*" ]; # fix weblinks not opening in default browser}
    };
  };
}
