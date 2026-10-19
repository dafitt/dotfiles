{
  lib,
  inputs,
  pkgs,
  ...
}:
with lib;
{
  #meta.doc = builtins.toFile "doc.md" "Personal settings.";

  imports =
    with inputs;
    with inputs.self.homeModules;
    [
      browser-firefox
      desktopEnvironment-gnome
      desktopEnvironment-umbriel
      development
      editor-micro
      fileManager-nautilus
      flatpak
      home-manager
      nix
      noctalia
      personalEnvironment
      terminal-alacritty
      top-btop
      xdg
    ];

  dafitt = {
    browser-firefox.setAsDefaultBrowser = true;
    desktopEnvironment-gnome.extensions.enable = true;
    editor-micro.setAsDefaultEditor = true;
    fileManager-nautilus.setAsDefaultFileManager = true;
    terminal-alacritty.setAsDefaultTerminal = true;
  };

  stylix = {
    autoEnable = false;
    targets = {
      alacritty.enable = true;
      btop.enable = true;
      fish.enable = true;
      micro.enable = true;
      yazi.enable = true;

      gnome.enable = false;
      gtk.enable = false;
    };
  };
  programs.zed-editor.userSettings.theme = mkForce "One Dark";

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    meld
  ];

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
