{ options, config, lib, pkgs, inputs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
{
  imports = [ ../../nixos/stylix/theme.nix ];

  # https://stylix.danth.me/options/hm.html
  stylix.enable = true;

  gtk = {
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme.override { color = "black"; };
    };
  };

  qt = {
    # https://github.com/nix-community/home-manager/blob/master/modules/misc/qt.nix
    #TODO wait for https://github.com/danth/stylix/pull/142
    enable = true;
    platformTheme.name = "adwaita";
    style.name = "adwaita-dark";
    style.package = pkgs.adwaita-qt;
  };
}
