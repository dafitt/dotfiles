{ inputs, ... }:

#> legacyPackages.x86_64-linux.homeConfigurations."nixos@TT-WCN13114".config
{
  home.stateVersion = "26.05";

  imports =
    with inputs;
    with inputs.self.homeModules;
    [
      imports

      browser-firefox
      development
      editor-micro
      fileManager-thunar
      home-manager
      obsidian
      personalEnvironment
      shell-fish
      stylix
      top-btop

      desktopEnvironment-umbriel
      noctalia
    ];

  gtk.gtk3.bookmarks = [
    "file:///mnt/u/DavidWORK"
    "file:///mnt/u/DavidWORK/adm"
    "file:///mnt/u/DavidWORK/work"
    "file:///mnt/f/group/Entwicklung/Elektronik/Allgemein/CAM-Daten/SchallerD CAM-Daten"
    "file:///mnt/f/group/Entwicklung/Elektronik/HerdeOeffentlich/SchallerD HerdeOeffentlich"
    "file:///mnt/f/group/Entwicklung/Elektronik/Allgemein/Inventar_GED_TRT Inventur"
    "file:///mnt/f/group/Entwicklung/Labor/Arbeitsordner/SchallerD Arbeitsordner-Labor"
    "file:///mnt/f/group/Entwicklung/Organisation/CGDO/L/P Werkstatt"
    "file:///mnt/f/group/Entwicklung/Organisation/CGDO/L/P/Arbeitsordner/SchallerD Werkstatt-Arbeitsordner"
    "file:///mnt/f/group/Entwicklung/Organisation/CGDO/L/P/Azubi Werkstatt-Azubi"
  ];
}
