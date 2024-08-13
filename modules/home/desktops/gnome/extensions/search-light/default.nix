{ options, config, lib, pkgs, inputs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.desktops.gnome.extensions.search-light;
in
{
  options.dafitt.desktops.gnome.extensions.search-light = with types; {
    enable = mkBoolOpt config.dafitt.desktops.gnome.extensions.enable "Enable Gnome extension 'search-light'.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs.gnomeExtensions; [ search-light ]
      ++ [ pkgs.imagemagick ];

    dconf.settings = {
      "org/gnome/shell/extensions/search-light" = {
        border-radius = 1.0;
        popup-at-cursor-monitor = true;
        scale-height = 0.5;
        scale-width = 0.5;
        shortcut-search = [ "<Super>space" ];
      };
      "org/gnome/desktop/wm/keybindings" = { switch-input-source-backward = [ ]; };
    };
  };
}
