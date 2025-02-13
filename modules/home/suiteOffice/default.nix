{ options, config, lib, pkgs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.suiteOffice;
  osCfg = osConfig.dafitt.suiteOffice or null;
in
{
  options.dafitt.suiteOffice = with types; {
    enable = mkBoolOpt (osCfg.enable or false) "Whether to enable the Office suite.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      cantarell-fonts
      ghostscript # pdf tools
      hunspell # Spell checking
      hunspellDicts.de_DE
      hunspellDicts.en_US-large
      inter # font
      liberation_ttf
      libreoffice-fresh # office suite
      pandoc # document converter
      pdfarranger # merge split rotate crop rearrange pdf pages
      scribus # Desktop Publishing (DTP) and Layout program for Linux
      evince # GNOME's document viewer
    ];

    services.flatpak.packages = [
      "com.github.rajsolai.textsnatcher" # Snatch Text with just a Drag
      "com.logseq.Logseq" # Connect your notes and knowledge
      "de.bund.ausweisapp.ausweisapp2" # Official authentication app for German ID card and residence permit
      "md.obsidian.Obsidian" # Markdown-based knowledge base
      "org.gnome.Evolution" # Manage your email, contacts and schedule
      "org.gnome.meld" # Compare and merge your files
      "org.gustavoperedo.FontDownloader" # Install fonts from online sources
    ];

    programs.zathura.enable = true; # pdf reader

    fonts.fontconfig.enable = true; # discover fonts and configurations installed through home.packages and nix-env

    wayland.windowManager.hyprland.settings = {
      exec-once = [
        "[workspace 3 silent;noinitialfocus] uwsm app -- ${pkgs.flatpak}/bin/flatpak run com.logseq.Logseq"
      ];
      windowrulev2 = [
        "float, class:scribus, title:(New Document)"
      ];
    };
  };
}
