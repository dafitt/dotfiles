{ inputs, pkgs, ... }:
{
  imports = with inputs; [
    stylix.homeModules.stylix
    ../../nixos/stylix/theme.nix
  ];

  # https://stylix.danth.me/options/hm.html
  stylix = {
    enable = true;

    icons = {
      enable = true;

      package = pkgs.papirus-icon-theme.override { color = "paleorange"; };
      dark = "Papirus-Dark";
      light = "Papirus";
      #package = pkgs.fluent-icon-theme.override { colorVariants = [ "orange" ]; };
      #dark = "Fluent-orange-dark";
      #light = "Fluent-orange-light";
    };
  };
}
