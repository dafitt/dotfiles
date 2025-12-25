{
  inputs,
  config,
  pkgs,
  ...
}:
{
  imports = with inputs; [
    stylix.homeModules.stylix
    ../../nixos/stylix/theme.nix
  ];

  # https://stylix.danth.me/options/hm.html
  stylix = {
    enable = true;

    iconTheme = {
      enable = true;

      package = pkgs.papirus-icon-theme.override { color = "paleorange"; };
      dark = "Papirus-Dark";
      light = "Papirus";
      #package = pkgs.fluent-icon-theme.override { colorVariants = [ "orange" ]; };
      #dark = "Fluent-orange-dark";
      #light = "Fluent-orange-light";
    };
  };

  wayland.windowManager.hyprland.settings = {
    exec-once = [
      # Fixes cursor themes in gnome apps under hyprland
      "gsettings set org.gnome.desktop.interface cursor-theme '${config.stylix.cursor.name}'"
      "gsettings set org.gnome.desktop.interface cursor-size ${toString config.stylix.cursor.size}"
    ];
  };
}
