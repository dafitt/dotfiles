{ options, config, lib, pkgs, osConfig ? { }, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.office;
  osCfg = osConfig.custom.office or null;
in
{
  options.custom.office = with types; {
    enableSuite = mkBoolOpt (osCfg.enableSuite or false) "Enable the office suite";
    installExtraPackages = mkBoolOpt cfg.enableSuite "Install extra office packages";
  };

  config = mkIf cfg.installExtraPackages {
    home.packages = with pkgs; [
      cantarell-fonts
      evince # GNOME's document viewer
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
      "de.bund.ausweisapp.ausweisapp2"
      "com.github.rajsolai.textsnatcher"
      "org.x.Warpinator"
    ];

    fonts.fontconfig.enable = true; # discover fonts and configurations installed through home.packages and nix-env

    # pdf reader
    programs.zathura = {
      enable = true;
    };
  };
}
