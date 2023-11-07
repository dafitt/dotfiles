{ config, lib, pkgs, ... }: {

  home.packages = with pkgs; [
    gnome.gnome-software # to search flatpaks grafically
  ];

  # add flatpaks .desktop binary paths
  home.sessionPath = [
    "/var/lib/flatpak/exports/share"
    "$HOME/.local/share/flatpak/exports/share"
  ];
  xdg.systemDirs.data = [
    "/var/lib/flatpak/exports/share"
    "$HOME/.local/share/flatpak/exports/share"
  ];

  home.file = {
    # Cursor theme fix
    # <https://nixos.wiki/wiki/Cursor_Themes>
    ".icons/default".source = "${config.gtk.cursorTheme.package}/share/icons/${config.gtk.cursorTheme.name}";

    # fix missing fonts (make a symlink to current font store)
    #".local/share/fonts".source = config.lib.file.mkOutOfStoreSymlink "/run/current-system/sw/share/X11/fonts"; # steam wont start
  };

  wayland.windowManager.hyprland.settings = {
    bind = [ ];
    exec-once = [
      # fix for flatpak open URLs with default browser <https://discourse.nixos.org/t/open-links-from-flatpak-via-host-firefox/15465/11>
      "systemctl --user import-environment PATH"
      "systemctl --user restart xdg-desktop-portal.service"
    ];
    exec = [ ];
    windowrulev2 = [
      # Steam
      "bordercolor rgb(1887d8), class:steam"
      "float, class:steam, title:(Friends List)|(Settings)"
    ];
  };
}
