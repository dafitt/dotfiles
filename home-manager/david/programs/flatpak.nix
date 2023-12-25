{ config, lib, pkgs, ... }: {

  home.packages = with pkgs; [
    flatpak
    gnome.gnome-software # to search flatpaks grafically
  ];


  # find flatpaks .desktop binary paths
  # $PATH
  home.sessionPath = [
    "$HOME/.local/share/flatpak/exports/share"
  ];
  # $XDG_DATA_DIRS
  xdg.systemDirs.data = [
    "$HOME/.local/share/flatpak/exports/share"
  ];

  home.file = {
    # Cursor theme fix
    # <https://nixos.wiki/wiki/Cursor_Themes>
    ".icons/default".source = "${config.stylix.cursor.package}/share/icons/${config.stylix.cursor.name}";

    # fix missing fonts (make a symlink to current font store)
    #".local/share/fonts".source = config.lib.file.mkOutOfStoreSymlink "/run/current-system/sw/share/X11/fonts"; # steam wont start
  };

  wayland.windowManager.hyprland.settings = {
    bind = [ ];
    exec-once = [
      # fix for flatpak open URLs with default browser <https://discourse.nixos.org/t/open-links-from-flatpak-via-host-firefox/15465/11>
      "systemctl --user import-environment PATH"
      "systemctl --user restart xdg-desktop-portal.service"
      "[workspace 3 silent;noinitialfocus] ${pkgs.flatpak}/bin/flatpak run md.obsidian.Obsidian"
    ];
    exec = [ ];
    windowrulev2 = [
      "bordercolor rgb(1887d8), class:steam"
      "float, class:steam, title:(Friends List)|(Settings)"
      "float, class:whatsapp-desktop-linux, title:WhatsApp"
    ];
  };
}
