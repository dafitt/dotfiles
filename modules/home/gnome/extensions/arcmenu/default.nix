{ options, config, lib, pkgs, inputs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.gnome.extensions.arcmenu;
in
{
  options.dafitt.gnome.extensions.arcmenu = with types; {
    enable = mkEnableOption "GNOME extension 'arcmenu'";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs.gnomeExtensions; [ arcmenu ];

    dconf.settings = {
      "org/gnome/shell/extensions/arcmenu" = {
        arc-menu-icon = 23;
        menu-button-position-offset = 0;
        menu-layout = "Elementary";
        position-in-panel = "Center";
        show-activities-button = true;
      };
    };
  };
}
