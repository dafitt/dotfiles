{ pkgs, inputs, ... }:
{
  imports = with inputs; [
    self.homeModules.flatpak
  ];

  home.packages = with pkgs; [
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
    pandoc
    pdfarranger
    scribus
  ];

  services.flatpak.packages = [
    "com.logseq.Logseq" # Connect your notes and knowledge
    "de.bund.ausweisapp.ausweisapp2" # Official authentication app for German ID card and residence permit
    "md.obsidian.Obsidian" # Markdown-based knowledge base
    "org.gnome.meld" # Compare and merge your files
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
