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
    # logseq # FIXME wait for update >0.10.15 because dependency electron-39 EOL
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
    window_rule = [
      {
        match.class = "scribus";
        match.title = "(New Document)";
        float = true;
      }
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
