{ options, config, lib, pkgs, inputs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.gnome.extensions;
in
{
  options.dafitt.gnome.extensions = with types; {
    enable = mkBoolOpt config.dafitt.gnome.enable "Whether to enable Gnome extensions.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ gnome-extension-manager ];

    dconf.settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;
      };
    };

    # NOTE extensions must still be enabled manually.
  };
}
