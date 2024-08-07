{ options, config, lib, pkgs, inputs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.desktops.gnome.extensions.rounded-window-corners;
in
{
  options.dafitt.desktops.gnome.extensions.rounded-window-corners = with types; {
    enable = mkBoolOpt false "Enable Gnome extension 'rounded-window-corners'.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs.gnomeExtensions; [ rounded-window-corners ];

    dconf.settings = {
      "org/gnome/shell" = {
        enabled-extensions = [ "rounded-window-corners@fxgn" ];
      };
    };
  };
}
