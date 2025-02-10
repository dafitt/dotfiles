{ options, config, lib, pkgs, inputs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.stylix;
  osCfg = osConfig.dafitt.stylix or null;
in
{
  imports = [ ../../nixos/stylix/theme.nix ];

  options.dafitt.stylix = with types; {
    enable = mkBoolOpt (osCfg.enable or false) "Whether to enable stylix.";
  };

  config = mkIf cfg.enable {
    # https://stylix.danth.me/options/hm.html
    stylix = {
      enable = true;

      iconTheme = {
        enable = true;

        # FIXME https://github.com/vinceliuice/Fluent-icon-theme/issues/96
        #package = pkgs.fluent-icon-theme;
        #dark = "Fluent-dark";
        #light = "Fluent-light";
        package = pkgs.papirus-icon-theme.override { color = "paleorange"; };
        dark = "Papirus-Dark";
        light = "Papirus";
      };
    };

    wayland.windowManager.hyprland.settings = {
      exec-once = [
        # Fixes cursor themes in gnome apps under hyprland
        "gsettings set org.gnome.desktop.interface cursor-theme '${config.stylix.cursor.name}'"
        "gsettings set org.gnome.desktop.interface cursor-size ${toString config.stylix.cursor.size}"
      ];
    };
  };
}
