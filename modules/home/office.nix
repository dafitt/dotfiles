{ pkgs, ... }:
{
  #meta.doc = builtins.toFile "doc.md" "A suite of office applications.";

  home.packages = with pkgs; [
    ausweisapp
    cantarell-fonts
    evince
    geary
    ghostscript
    hunspell
    hunspellDicts.de_DE
    hunspellDicts.en_US-large
    inter
    liberation_ttf
    libreoffice-fresh
    logseq
    meld
    pandoc
    pdfarranger
    scribus
  ];

  services.flatpak.packages = [
    "org.gustavoperedo.FontDownloader" # Install fonts from online sources
  ];

  programs.zathura.enable = true; # pdf reader

  fonts.fontconfig.enable = true; # discover fonts and configurations installed through home.packages and nix-env

  wayland.windowManager.hyprland.settings = {
    windowrule = [
      "match:class scribus, match:title (New Document), float on"
    ];
  };
  programs.niri.settings = {
    window-rules = [
      {
        matches = [
          {
            app-id = "scribus";
            title = "New Document";
          }
        ];
        open-floating = true;
      }
    ];
  };
}
