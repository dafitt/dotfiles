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
      shell-fish
      terminal-alacritty
      top-btop
      xdg
    ];

  dafitt = {
    browser-firefox.autostart = true;
    browser-firefox.setAsDefaultBrowser = true;
    desktopEnvironment-gnome.extensions.enable = true;
    editor-micro.setAsDefaultEditor = true;
    fileManager-nautilus.setAsDefaultFileManager = true;
    noctalia.setAsDefaultLauncher = true;
    shell-fish.setAsDefaultShell = true;
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

  programs.umbriel.settings = {
    general.autostart = [
      "/opt/microsoft/msedge/microsoft-edge --profile-directory=Default --app-id=pkooggnaalmfkidjmlhoelhdllpphaga --app-url=https://outlook.office365.com/mail/"
      "/opt/microsoft/msedge/microsoft-edge --profile-directory=Default --app-id=cifhbcnohmdccbgoicgdjpfamggdegmo '--app-url=https://teams.microsoft.com/v2/?clientType=pwa'"
    ];
    window_rule = [
      {
        match.app_id = "^msedge-.*";
        match.title = [
          "^Microsoft Teams"
          "^Outlook \\(PWA\\)"
        ];
        default_workspace = 4;
      }
    ];
  };

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
