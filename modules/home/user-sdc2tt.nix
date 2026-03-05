{
  config,
  lib,
  pkgs,
  inputs,
  perSystem,
  ...
}:
with lib;
{
  imports =
    with inputs;
    with inputs.self.homeModules;
    [
      browser-firefox
      desktopEnvironment-gnome
      development
      editor-micro
      fileManager-thunar
      flatpak
      home-manager
      nix
      personalEnvironment
      top-btop
      xdg
    ];

  dafitt = {
    browser-firefox.setAsDefaultBrowser = true;
    desktopEnvironment-gnome.extensions.enable = true;
    editor-micro.setAsDefaultEditor = true;
  };

  stylix.targets = {
    gnome.enable = false;
    gtk.enable = false;
  };

  home.packages = with pkgs; [
    perSystem.nixGL.nixGLIntel
    perSystem.nixGL.nixVulkanIntel

    meld
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
