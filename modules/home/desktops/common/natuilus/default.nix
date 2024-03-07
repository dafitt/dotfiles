{ config, lib, options, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.desktops.common.natuilus;
in
{
  options.custom.desktops.common.natuilus = with types; {
    enable = mkBoolOpt config.custom.desktops.common.enable "Enable natuilus file manager";
  };

  config = mkIf cfg.enable {
    # The file manager for GNOME
    home.packages = with pkgs; [
      gnome.nautilus
      nautilus-open-any-terminal
    ];

    dconf.settings = {
      "org/gnome/nautilus/preferences" = {
        default-folder-viewer = "list-view";
        show-create-link = true;
        show-delete-permanently = true;
        show-image-thumbnails = "never";
      };
      "org/gnome/nautilus/icon-view" = {
        captions = [ "size" "none" "none" ];
      };
      "org/gnome/nautilus/list-view" = {
        default-column-order = [
          "name"
          "size"
          "type"
          "owner"
          "group"
          "permissions"
          "date_modified"
          "date_modified_with_time"
          "date_accessed"
          "recency"
          "starred"
          "detailed_type"
          "where"
        ];
        default-visible-columns = [ "name" "type" "size" "date_modified" "permissions" ];
        default-zoom-level = "small";
      };
      "com/github/stunkymonkey/nautilus-open-any-terminal" = {
        terminal = "kitty";
      };
    };

    wayland.windowManager.hyprland.settings = {
      bind = [ "ALT SUPER, F, exec, ${pkgs.gnome.nautilus}/bin/nautilus" ];
      exec-once = [ "[workspace 2 silent] ${pkgs.gnome.nautilus}/bin/nautilus" ];
    };
  };
}
