{
  flake,
  inputs,
  pkgs,
  ...
}:
{
  #meta.doc = builtins.toFile "doc.md" ''
  #  Enables home-environment-wide theming.
  #  <https://stylix.danth.me/>
  #'';

  imports = with inputs; [
    self.homeModules.home-manager-mutableFiles

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

  xdg.configFile = flake.lib.mkMutableFiles [
    "gtk-3.0/settings.ini"
    "gtk-3.0/settings.ini"
    "gtk-4.0/settings.ini"
  ];
}
