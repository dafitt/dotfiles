{ options, config, lib, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.features.desktops.gnome;
in
{
  options.features.desktops.gnome = with types; {
    enable = mkBoolOpt false "Enable the Gnome desktop environment";
  };

  config = mkIf cfg.enable {
    services.xserver.desktopManager.gnome.enable = true;
  };
}
