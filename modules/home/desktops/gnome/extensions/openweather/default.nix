{ options, config, lib, pkgs, inputs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.desktops.gnome.extensions.openweather;
in
{
  options.dafitt.desktops.gnome.extensions.openweather = with types; {
    enable = mkBoolOpt false "Enable Gnome extension 'openweather'.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs.gnomeExtensions; [ ];

    dconf.settings = {
      "org/gnome/shell/extensions/openweatherrefined" = {
        delay-ext-init = 10;
        position-index = 1;
        show-sunsetrise-in-panel = true;
        show-text-in-panel = true;
        use-system-icons = true;
        wind-direction = true;
      };
    };
  };
}
