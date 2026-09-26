{ inputs, pkgs, ... }:
{
  #meta.doc = builtins.toFile "doc.md" ''
  #  Enables home-environment-wide theming.
  #  <https://stylix.danth.me/>
  #'';

  imports = with inputs; [
    stylix.homeModules.stylix
    ../../nixos/stylix/theme.nix
  ];

  # https://stylix.danth.me/options/hm.html
  stylix = {
    enable = true;

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

  # gtk.gtk4.iconTheme.name = "Adwaita";
  # gtk.gtk4.iconTheme.package = pkgs.adwaita-icon-theme;
}
