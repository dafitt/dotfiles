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
    browsers.default = "firefox";
    flatpak.enable = true;
  };

  stylix.autoEnable = false;
  stylix.iconTheme.package = mkForce pkgs.papirus-icon-theme;
  stylix.targets.gtk.enable = true;
  stylix.targets.gnome.enable = true;
  stylix.targets.fish.enable = true;
  stylix.targets.vscode.enable = true;
}
