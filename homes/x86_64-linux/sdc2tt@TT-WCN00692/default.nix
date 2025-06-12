#nix-repl> homeConfigurations."sdc2tt@TT-WCN00692".config

{ config, lib, pkgs, inputs, ... }:

with lib;
with lib.dafitt; {
  imports = with inputs; [
  ];

  dafitt = {
    enableDefaults = true;
    flatpak.enable = false;
    hyprland.enable = true;
    passwordManagers.default = null;
    suiteDevelopment.enable = true;
    syncthing.enable = false;
    xdg.enable = false;
  };

  stylix.iconTheme.package = mkForce pkgs.papirus-icon-theme;
}
