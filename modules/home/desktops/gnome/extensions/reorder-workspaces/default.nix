{ options, config, lib, pkgs, inputs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.desktops.gnome.extensions.reorder-workspaces;
in
{
  options.dafitt.desktops.gnome.extensions.reorder-workspaces = with types; {
    enable = mkBoolOpt config.dafitt.desktops.gnome.extensions.enable "Enable Gnome extension 'reorder-workspaces'.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs.gnomeExtensions; [ reorder-workspaces ];

    dconf.settings = {
      "org/gnome/shell" = {
        enabled-extensions = [ "reorder-workspaces@jer.dev" ];
      };
      "org/gnome/shell/extensions/reorder-workspaces" = {
        move-workspace-prev = [ "<Shift><Super>Page_Down" ];
        move-workspace-next = [ "<Shift><Super>Page_Up" ];
      };
    };
  };
}
