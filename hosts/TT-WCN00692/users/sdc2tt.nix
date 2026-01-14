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
  programs.zed-editor.package = mkForce (config.lib.nixGL.wrap pkgs.zed-editor);

  gtk.gtk3.bookmarks = [
    "file:///home/sdc2tt/DriveU/DavidWORK"
    "file:///home/sdc2tt/DriveU/DavidWORK/adm"
    "file:///home/sdc2tt/DriveU/DavidWORK/work"
    "file:///home/sdc2tt/DriveF/group/Entwicklung/Elektronik/Allgemein/CAM-Daten/SchallerD CAM-Daten"
    "file:///home/sdc2tt/DriveF/group/Entwicklung/Elektronik/HerdeOeffentlich/SchallerD HerdeOeffentlich"
    "file:///home/sdc2tt/DriveF/group/Entwicklung/Elektronik/Allgemein/Inventar_GED_TRT Inventur"
    "file:///home/sdc2tt/DriveF/group/Entwicklung/Labor/Arbeitsordner/SchallerD Arbeitsordner-Labor"
    "file:///home/sdc2tt/DriveF/group/Entwicklung/Organisation/CGDO/L/P Werkstatt"
    "file:///home/sdc2tt/DriveF/group/Entwicklung/Organisation/CGDO/L/P/Arbeitsordner/SchallerD Werkstatt-Arbeitsordner"
    "file:///home/sdc2tt/DriveF/group/Entwicklung/Organisation/CGDO/L/P/Azubi Werkstatt-Azubi"
  ];
}
