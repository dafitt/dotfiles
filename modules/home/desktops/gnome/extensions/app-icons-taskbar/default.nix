{ options, config, lib, pkgs, inputs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.desktops.gnome.extensions.app-icons-taskbar;
in
{
  options.dafitt.desktops.gnome.extensions.app-icons-taskbar = with types; {
    enable = mkBoolOpt config.dafitt.desktops.gnome.extensions.enable "Whether to enable Gnome extension 'app-icons-taskbar'.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs.gnomeExtensions; [ app-icons-taskbar ]
      ++ [ pkgs.imagemagick ];

    dconf.settings = {
      "org/gnome/shell/extensions/aztaskbar" = {
        favorites = false;
        icon-size = 24;
        main-panel-height = (config.lib.gvariant.mkTuple [ false 40 ]);
        middle-click-action = "RAISE";
        override-panel-clock-format = (config.lib.gvariant.mkTuple [ true "%F :: %A :: %R" ]);
        position-offset = 3;
        window-previews = false;
      };
    };
  };
}
