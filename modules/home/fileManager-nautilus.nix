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
  #meta.doc = builtins.toFile "doc.md" "Installs and configures the Nautilus file manager.";

  options.dafitt.fileManager-nautilus = with types; {
    setAsDefaultFileManager = mkEnableOption "making it the default file manager";

    autostart = mkEnableOption "autostart at user login";

    workspace = mkOption {
      type = int;
      default = 3;
      description = "Which workspace is mainly to be used for this application.";
    };
  };

  config = {
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
        {
          _args = [
            "SUPER + ALT + F"
            (mkLuaInline ''hl.dsp.exec_cmd("uwsm app -- ${getExe pkgs.nautilus}")'')
            { description = "Open Nautilus file manager"; }
          ];
        }
      ];
      on = optionals cfg.setAsDefaultFileManager [
        {
          _args = [
            "hyprland.start"
            (mkLuaInline ''function() hl.exec_cmd("uwsm app -- ${getExe pkgs.nautilus}", { workspace = "${toString cfg.workspace} silent" }) end'')
          ];
        }
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
