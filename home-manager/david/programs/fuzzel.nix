{ config, lib, pkgs, ... }: {

  # Application launcher for wlroots based Wayland compositors
  # https://codeberg.org/dnkl/fuzzel
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        # settings <https://man.archlinux.org/man/fuzzel.ini.5.en>

        terminal = "$TERMINAL";
        prompt = "🔎";
        font = lib.mkForce "${config.stylix.fonts.serif.name}:size=16";
        letter-spacing = 1;
        icon-theme = "${config.gtk.iconTheme.name}";
        layer = "overlay";
      };
      border = {
        width = 2;
        #radius = 0;
      };
    };
  };

  wayland.windowManager.hyprland.settings = {
    bind = [ "SUPER, SPACE, exec, ${pkgs.fuzzel}/bin/fuzzel" ];
  };
}
