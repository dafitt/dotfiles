{ config, pkgs, inputs, ... }: {

  # [Documentation](https://danth.github.io/stylix/index.html)
  stylix = {
    image = ./wallpaper.png;

    # [base16 Styling Guidelines](https://github.com/chriskempson/base16/blob/main/styling.md)
    # [explore themes](https://github.com/tinted-theming/base16-schemes)
    # [explore themes grafical](https://vimcolorschemes.com/tinted-theming/base16-vim)
    # some good themes: catppuccin-mocha, gruvbox-dark-medium, onedark, everforest, material-darker, da-one-gray, hardcore, chalk, tokyodark, ashes, mountain, tender
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    #$ use colors with ${config.lib.stylix.colors.base00}
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
      # manages `home.pointerCursor`
      package = pkgs.phinger-cursors; # TODO: 24.05 switch to hyprcursor if hyprland>=v0.37.0
      name = "phinger-cursors-light";
    };

    fonts = rec {
      sansSerif = serif;
      serif = {
        package = pkgs.ubuntu_font_family;
        name = "Ubuntu";
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
}
