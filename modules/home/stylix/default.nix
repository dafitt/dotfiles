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
  };
}
