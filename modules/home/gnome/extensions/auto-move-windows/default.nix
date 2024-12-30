{ options, config, lib, pkgs, inputs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.gnome.extensions.auto-move-windows;
in
{
  options.dafitt.gnome.extensions.auto-move-windows = with types; {
    enable = mkEnableOption "GNOME extension 'auto-move-windows'";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs.gnomeExtensions; [ ];

    dconf.settings = {
      "org/gnome/shell/extensions/auto-move-windows" = {
        application-list = [
          "librewolf.desktop:1"
          "org.gnome.Nautilus.desktop:2"
          "md.obsidian.Obsidian.desktop:3"
          "code.desktop:4"
        ];
      };
    };
  };
}
