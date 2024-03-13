# Documentation: <https://danth.github.io/stylix/index.html>
{ config, pkgs, inputs, ... }: {

  imports = [
    inputs.stylix.homeManagerModules.stylix
  ];

  stylix = {
    image = ./wallpaper.png;

    # explore themes <https://github.com/tinted-theming/base16-schemes>
    # explore themes grafical <https://vimcolorschemes.com/tinted-theming/base16-vim>
    # some good themes: catppuccin-mocha, gruvbox-dark-medium, onedark, everforest, material-darker, da-one-gray, hardcore, chalk, tokyodark, ashes, mountain, tender
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    # base16 Styling Guidelines: https://github.com/chriskempson/base16/blob/main/styling.md
    #$ use colors with ${config.lib.stylix.colors.base00}
    override = {
      # cattppuccin-mocha: but less blue in the background
      # <https://github.com/catppuccin/base16>
      base00 = "1e1e1e"; # base
      base01 = "181818"; # mantle
      base02 = "313232"; # surface0
      base03 = "454748"; # surface1
      base04 = "585b5d"; # surface2
      base05 = "cdd6d9"; # text
    };

    polarity = "dark"; # for epiphany, flatpaks

    cursor = {
      # Manages home.pointerCursor
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };

    fonts = {
      sansSerif = config.stylix.fonts.serif;
      serif = {
        package = pkgs.ubuntu_font_family;
        name = "Ubuntu";
        #package = pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; };
        #name = "FiraCode Nerd Font";
      };
      monospace = {
        package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
        name = "JetBrainsMono Nerd Font";
      };
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
      sizes = {
        applications = 12; # used by applications
        desktop = 11; # used in window titles/bars/widgets elements of the desktop
        popups = 14; # for notifications/popups and in general overlay elements of the desktop
        terminal = 12; # for terminals/text editors
      };
    };

    gtk = {
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme.override { color = "black"; };
      };
    };

    qt = {
      enable = true;
      platformTheme = "gnome";
      style = {
        name = "adwaita-dark";
        package = pkgs.adwaita-qt;
      };
    };
  };
}
