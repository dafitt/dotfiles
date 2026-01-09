{
  config,
  lib,
  pkgs,
  inputs,
  perSystem,
  ...
}:
with lib;
#> perSystem.self.homeConfigurations."sdc2tt@TT-WCN00692"
#$ home-manager --flake .#sdc2tt@TT-WCN00692 switch
{
  home.stateVersion = "25.11";

  imports =
    with inputs;
    with inputs.self.homeModules;
    [
      niri.homeModules.config

      browser-firefox
      desktopEnvironment-gnome
      development
      editor-micro
      fileManager-yazi
      flatpak
      nix
      personalEnvironment
      top-btop
    ];

  dafitt = {
    browser-firefox.setAsDefaultBrowser = true;
    editor-micro.setAsDefaultEditor = true;
  };

  nixpkgs.config.allowUnfree = true;

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

  home.packages = [
    perSystem.nixGL.nixGLIntel
  ];

  services.flatpak.packages = [
    "com.logseq.Logseq" # Connect your notes and knowledge
    "org.gnome.meld" # Compare and merge your files
  ];

  targets.genericLinux.nixGL = {
    packages = inputs.nixGL.packages;
    vulkan.enable = true;
  };
  wayland.windowManager.hyprland.package = (config.lib.nixGL.wrap pkgs.hyprland);
  programs.vscode.package = mkForce (config.lib.nixGL.wrap pkgs.vscodium);
  programs.kitty.package = mkForce (config.lib.nixGL.wrap pkgs.kitty);
  programs.zed-editor.package = mkForce (config.lib.nixGL.wrap pkgs.zed-editor);

  #wayland.windowManager.hyprland.settings.env = [ "AQ_DRM_DEVICES,/dev/dri/card1" ];
}
