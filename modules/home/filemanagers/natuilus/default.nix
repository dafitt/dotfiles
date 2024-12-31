{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.filemanagers.nautilus;
in
{
  options.dafitt.filemanagers.nautilus = with types; {
    enable = mkEnableOption "file manager 'nautilus'";

    autostart = mkBoolOpt true "Whether to autostart at user login.";
    configureKeybindings = mkBoolOpt false "Whether to configure keybindings.";
  };

  config = mkIf cfg.enable {
    # The file manager for GNOME
    home.packages = with pkgs; [
      nautilus
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
      bind = mkIf cfg.configureKeybindings [ "SUPER_ALT, F, exec, ${pkgs.nautilus}/bin/nautilus" ];
      exec-once = mkIf cfg.autostart [ "[workspace 2 silent] ${pkgs.nautilus}/bin/nautilus" ];
    };

    # needs inputs.xdg-autostart.homeManagerModules.xdg-autostart
    xdg.autoStart.desktopItems = mkIf cfg.autostart {
      nautilus = pkgs.makeDesktopItem {
        name = "nautilus";
        desktopName = "Files";
        exec = "${pkgs.nautilus}/bin/nautilus";
      };
    };
  };
}
