{ config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.filemanagers.pcmanfm;
in
{
  options.dafitt.filemanagers.pcmanfm = with types; {
    enable = mkEnableOption "file manager 'pcmanfm'";

    autostart = mkBoolOpt false "Whether to autostart at user login.";
    configureKeybindings = mkBoolOpt false "Whether to configure keybindings.";
    workspace = mkOpt int 3 "Which workspace is mainly to be used for this application.";
  };

  config = mkIf cfg.enable {
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
      bind = mkIf cfg.configureKeybindings [ "SUPER_ALT, F, exec, uwsm app -- ${pkgs.pcmanfm}/bin/pcmanfm" ];
      exec-once = mkIf cfg.autostart [ "[workspace ${toString cfg.workspace} silent] uwsm app -- ${pkgs.pcmanfm}/bin/pcmanfm" ];
    };

    # needs inputs.xdg-autostart.homeManagerModules.xdg-autostart
    xdg.autoStart.packages = mkIf cfg.autostart [ pkgs.pcmanfm ];
  };
}
