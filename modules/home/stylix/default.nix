{
  flake,
  lib,
  config,
  inputs,
  pkgs,
  ...
}:
with lib;
{
  #meta.doc = builtins.toFile "doc.md" ''
  #  Enables home-environment-wide theming.
  #  <https://stylix.danth.me/>
  #'';

  imports = with inputs; [
    stylix.homeModules.stylix
    ./theme.nix
  ];

  config = mkMerge [
    {
      # https://stylix.danth.me/options/hm.html
      stylix = {
        enable = true;
        overlays.enable = mkDefault false; # [stylix: incompatible with home-manager.useGlobalPkgs](https://github.com/nix-community/stylix/issues/1832)

        icons = {
          enable = true;

          # package = pkgs.adwaita-icon-theme;
          # dark = "Adwaita";
          # light = "Adwaita";
          package = pkgs.papirus-maia-icon-theme;
          dark = "Papirus-Dark-Maia";
          light = "Papirus-Light-Maia";
          # package = pkgs.papirus-icon-theme.override { color = "paleorange"; };
          # dark = "Papirus-Dark";
          # light = "Papirus";
          #package = pkgs.fluent-icon-theme.override { colorVariants = [ "orange" ]; };
          #dark = "Fluent-orange-dark";
          #light = "Fluent-orange-light";
        };
      };

      # auto-discover fonts
      fonts.fontconfig.enable =
        with config.stylix.targets.font-packages;
        mkIf (enable == true && fonts.enable == true) true;
    }

    (mkIf (config.home.activation ? mutableFileGeneration) {
      gtk.gtk2.force = true;
      home.file =
        with config.gtk;
        flake.lib.mkMutableFiles (optional (enable == true && gtk2.enable == true) gtk2.configLocation);
      xdg.configFile =
        with config.gtk;
        flake.lib.mkMutableFiles (
          optionals (enable == true && gtk3.enable == true) [
            "gtk-3.0/settings.ini"
            "gtk-3.0/gtk.css"
          ]
          ++ optionals (enable == true && gtk4.enable == true) [
            "gtk-4.0/settings.ini"
            "gtk-4.0/gtk.css"
          ]
        );
    })
  ];
}
