#nix-repl> homeConfigurations."sdc2tt@TT-WCN00692".config

{ config, lib, pkgs, inputs, ... }:

with lib;
with lib.dafitt; {
  imports = with inputs; [
  ];

  dafitt = {
    editors.default = "micro";
    filemanagers.yazi.enable = true;
    personalEnvironment.enable = true;
    suiteDevelopment.enable = true;
  };

  stylix.targets.gtk.enable = false;
  stylix.targets.gnome.enable = false;
  stylix.iconTheme.package = mkForce pkgs.papirus-icon-theme;
}
