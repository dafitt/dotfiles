#nix-repl> homeConfigurations."sdc2tt@TT-WCN00692".config

{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

with lib;
with lib.dafitt;
{
  imports = with inputs; [
  ];

  dafitt = {
    yazi.enable = true;
    firefox.enable = true;
    firefox.setAsDefaultBrowser = true;
    flatpak.enable = true;
    hyprland.enable = true;
    micro.enable = true;
    micro.setAsDefaultEditor = true;
    personalEnvironment.enable = true;
    suiteDevelopment.enable = true;
  };

  home.packages = with pkgs; [
    nixgl.nixGLIntel
  ];

  services.flatpak.packages = [
    "com.github.rajsolai.textsnatcher" # Snatch Text with just a Drag
    "com.logseq.Logseq" # Connect your notes and knowledge
    "org.gnome.meld" # Compare and merge your files
  ];

  stylix = {
    autoEnable = false;
    iconTheme.package = mkForce pkgs.papirus-icon-theme;
    targets = {
      fish.enable = true;
      gnome.enable = true;
      gtk.enable = true;
      vscode.enable = true;
      yazi.enable = true;
    };
  };

  nixGL = {
    packages = inputs.nixGL.packages;
    vulkan.enable = true;
  };
  wayland.windowManager.hyprland.package = (config.lib.nixGL.wrap pkgs.hyprland);
  programs.vscode.package = mkForce (config.lib.nixGL.wrap pkgs.vscodium);
  programs.kitty.package = mkForce (config.lib.nixGL.wrap pkgs.kitty);
  programs.zed-editor.package = mkForce (config.lib.nixGL.wrap pkgs.zed-editor);

  #wayland.windowManager.hyprland.settings.env = [ "AQ_DRM_DEVICES,/dev/dri/card1" ];
}
