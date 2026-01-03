{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dafitt.fileManager-pcmanfm;
in
{
  options.dafitt.fileManager-pcmanfm = with types; {
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
    # Extremely fast and lightweight GTK file manager
    # https://blog.lxde.org/category/pcmanfm/
    home.packages = with pkgs; [ pcmanfm ];

    home.file.".config/pcmanfm/pcmanfm.conf".text = ''
      [config]
      bm_open_method=0

      [volume]
      mount_on_startup=1
      mount_removable=1
      autorun=1

      [ui]
      always_show_tabs=1
      max_tab_chars=32
      win_width=1000
      win_height=1000
      splitter_pos=150
      media_in_new_tab=1
      desktop_folder_new_win=0
      change_tab_on_drop=1
      close_on_unmount=1
      maximized=1
      focus_previous=0
      side_pane_mode=places
      view_mode=list
      show_hidden=0
      show_thumbs=0
      sort=name;ascending;
      columns=name;owner;perm;size;mtime;
      toolbar=newtab;navigation;home;
      show_statusbar=1
      pathbar_mode_buttons=0
      prefs_app=SUDO_ASKPASS=/usr/lib/pipanel/pwdpip.sh pipanel
      common_bg=0
    '';

    wayland.windowManager.hyprland.settings = {
      bind = optionals cfg.setAsDefaultFileManager [
        "Super&Alt, F, exec, uwsm app -- ${getExe pkgs.pcmanfm}"
      ];
      exec-once = optionals cfg.autostart [
        "[workspace ${toString cfg.workspace} silent] uwsm app -- ${getExe pkgs.pcmanfm}"
      ];
    };
    programs.niri.settings = {
      binds."Mod+Alt+F" = mkIf cfg.setAsDefaultFileManager {
        action.spawn-sh = "uwsm app -- ${getExe pkgs.pcmanfm}";
      };
      spawn-at-startup = optionals cfg.autostart [
        { sh = "uwsm app -- ${getExe pkgs.pcmanfm}"; }
      ];
    };
  };
}
