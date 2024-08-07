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
        disable-user-extensions = false;
      };
    };
  };
}
