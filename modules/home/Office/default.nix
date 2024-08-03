{ options, config, lib, pkgs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.Office;
  osCfg = osConfig.dafitt.Office or null;
in
{
  options.dafitt.Office = with types; {
    enableSuite = mkBoolOpt (osCfg.enableSuite or false) "Enable the Office suite";
  };

  config = mkIf cfg.enableSuite {
    home.packages = with pkgs; [
      cantarell-fonts
      hunspell # Spell checking
      hunspellDicts.de_DE
      hunspellDicts.en_US-large
      inter # font
      liberation_ttf
      libreoffice-fresh # office suite
      pandoc # document converter
      pdfarranger # merge split rotate crop rearrange pdf pages
      ghostscript # pdf tools
    ];

    services.flatpak.packages = [
      "com.github.rajsolai.textsnatcher" # Snatch Text with just a Drag
      "de.bund.ausweisapp.ausweisapp2" # Official authentication app for German ID card and residence permit
      "org.gustavoperedo.FontDownloader" # Install fonts from online sources
    ];

    fonts.fontconfig.enable = true; # discover fonts and configurations installed through home.packages and nix-env

    # pdf reader
    programs.zathura = {
      enable = true;
    };
  };
}
