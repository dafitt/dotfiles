{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.desktops.common.natuilus;
in
{
  options.dafitt.desktops.common.natuilus = with types; {
    enable = mkBoolOpt config.dafitt.desktops.common.enable "Enable natuilus file manager";
    autostart = mkBoolOpt true "Start natuilus on login";
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
      bind = [ "SUPER_ALT, F, exec, ${pkgs.gnome.nautilus}/bin/nautilus" ];
      exec-once = mkIf cfg.autostart [ "[workspace 2 silent] ${pkgs.gnome.nautilus}/bin/nautilus" ];
    };
  };
}
