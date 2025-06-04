#nix-repl> homeConfigurations."sdc2tt@TRTWCW2263".config

{ config, lib, pkgs, inputs, ... }:

with lib;
with lib.dafitt; {
  imports = with inputs; [
  ];

  dafitt = {
    filemanagers.yazi.enable = true;
    # hyprland.enable = true;
    # hyprland.hypridle.enable = false;
    suiteDevelopment.enable = true;
  };

  stylix.iconTheme.package = mkForce pkgs.papirus-icon-theme;
}
