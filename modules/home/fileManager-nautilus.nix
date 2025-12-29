{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dafitt.fileManager-nautilus;
in
{
  options.dafitt.fileManager-nautilus = with types; {
    setAsDefaultFileManager = mkEnableOption "making it the default file manager";

    autostart = mkOption {
      type = bool;
      default = cfg.setAsDefaultFileManager;
      description = "Whether to autostart at user login.";
    };
    workspace = mkOption {
      type = int;
      default = 3;
      description = "Which workspace is mainly to be used for this application.";
    };
  };

  config = {
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
      };
      "org/gnome/nautilus/icon-view" = {
        captions = [
          "size"
          "none"
          "none"
        ];
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
        default-visible-columns = [
          "name"
          "type"
          "size"
          "date_modified"
          "permissions"
        ];
        default-zoom-level = "small";
      };
      "com/github/stunkymonkey/nautilus-open-any-terminal" = {
        terminal = "kitty";
      };
    };

    wayland.windowManager.hyprland.settings = {
      bind = optionals cfg.setAsDefaultFileManager [
        "SUPER_ALT, F, exec, uwsm app -- ${getExe pkgs.nautilus}"
      ];
      exec-once = optionals cfg.autostart [
        "[workspace ${toString cfg.workspace} silent] uwsm app -- ${getExe pkgs.nautilus}"
      ];
    };
    programs.niri.settings = {
      binds."Mod+Alt+F" = mkIf cfg.setAsDefaultFileManager {
        action.spawn-sh = "uwsm app -- ${getExe pkgs.nautilus}";
      };
      spawn-at-startup = optionals cfg.autostart [
        { sh = "uwsm app -- ${getExe pkgs.nautilus}"; }
      ];
    };
  };
}
