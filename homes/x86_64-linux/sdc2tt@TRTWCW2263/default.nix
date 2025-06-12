#nix-repl> homeConfigurations."sdc2tt@TRTWCW2263".config

{ config, lib, pkgs, inputs, ... }:

with lib;
with lib.dafitt; {
  imports = with inputs; [
  ];

  dafitt = {
    filemanagers.yazi.enable = true;
    personalEnvironment.enable = true;
    suiteDevelopment.enable = true;
  };

  stylix.iconTheme.package = mkForce pkgs.papirus-icon-theme;
}
