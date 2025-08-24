{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

with lib;
with lib.dafitt;
{
  stylix = mkDefault {

    image = ./wallpaper.png;

    # [base16 Styling Guidelines](https://github.com/chriskempson/base16/blob/main/styling.md)
    # [explore themes](https://github.com/tinted-theming/base16-schemes)
    # [explore themes grafical](https://vimcolorschemes.com/tinted-theming/base16-vim)
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    # use colors with
    #$ ${config.lib.stylix.colors.base00}
    #$ ${config.lib.stylix.colors.withHashtag.base00}

    override = {
      # [cattppuccin-mocha](https://github.com/catppuccin/base16/blob/main/base16/mocha.yaml) but less blue in the background
      base00 = "1e1e1e"; # base
      base01 = "181818"; # mantle
      base02 = "313232"; # surface0
      base03 = "454748"; # surface1
      base04 = "585b5d"; # surface2
      base05 = "cdd6d9"; # text
    };

    polarity = "dark"; # for epiphany, flatpaks

    cursor = {
      name = "phinger-cursors-light";
      package = pkgs.phinger-cursors;
      size = 32;
    };

    fonts = rec {
      sansSerif = serif;
      serif = {
        package = pkgs.ubuntu_font_family;
        name = "Ubuntu";
      };
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
      sizes = {
        applications = 12; # used by applications
        desktop = 14; # used in window titles/bars/widgets elements of the desktop
        popups = 14; # for notifications/popups and in general overlay elements of the desktop
        terminal = 14; # for terminals/text editors
      };
    };
  };
}
