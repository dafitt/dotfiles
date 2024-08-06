{ options, config, lib, pkgs, inputs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.desktops.gnome.extensions;
in
{
  options.dafitt.desktops.gnome.extensions = with types; {
    enable = mkBoolOpt config.dafitt.desktops.gnome.enable "Enable Gnome extensions.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ gnome-extension-manager ];

    dconf.settings = {

      "org/gnome/shell" = {
        favorite-apps = [
          "librewolf.desktop"
          "org.wezfurlong.wezterm.desktop"
          "org.gnome.Nautilus.desktop"
          "org.gnome.Calendar.desktop"
          "obsidian.desktop"
          "transmission-gtk.desktop"
          "caprine.desktop"
          "teams-for-linux.desktop"
          "discord.desktop"
          "spotify.desktop"
          "com.usebottles.bottles.desktop"
          "org.gnome.Software.desktop"
        ];
      };
      "org/gnome/shell/extensions/auto-move-windows" = {
        application-list = [
          "librewolf.desktop:1"
          "org.gnome.Nautilus.desktop:2"
          "md.obsidian.Obsidian.desktop:3"
          "code.desktop:4"
        ];
      };
    };
  };
}
