{ options, config, lib, pkgs, inputs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.desktops.gnome.extensions.blur-my-shell;
in
{
  options.dafitt.desktops.gnome.extensions.blur-my-shell = with types; {
    enable = mkBoolOpt config.dafitt.desktops.gnome.extensions.enable "Enable Gnome extension 'blur-my-shell'.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs.gnomeExtensions; [ blur-my-shell ];

    dconf.settings = { };
  };
}
