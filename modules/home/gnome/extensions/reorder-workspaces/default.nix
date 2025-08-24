{
  config,
  lib,
  pkgs,
  inputs,
  osConfig ? { },
  ...
}:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.gnome.extensions.reorder-workspaces;
in
{
  options.dafitt.gnome.extensions.reorder-workspaces = with types; {
    enable = mkEnableOption "GNOME extension 'reorder-workspaces'";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs.gnomeExtensions; [ reorder-workspaces ];

    dconf.settings = {
      "org/gnome/shell/extensions/reorder-workspaces" = {
        move-workspace-prev = [ "<Shift><Super>Page_Up" ];
        move-workspace-next = [ "<Shift><Super>Page_Down" ];
      };
      "org/gnome/desktop/wm/keybindings" = {
        move-to-workspace-left = [ ];
        move-to-workspace-right = [ ];
      };
    };
  };
}
