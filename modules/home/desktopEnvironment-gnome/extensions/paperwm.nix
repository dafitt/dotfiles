{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dafitt.gnome.extensions.paperwm;
in
{
  options.dafitt.gnome.extensions.paperwm = {
    enable = mkEnableOption "GNOME extension 'paperwm'";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs.gnomeExtensions; [ paperwm ];

    dconf.settings = {
      "org/gnome/shell/extensions/paperwm" = {
        default-focus-mode = 0;
        horizontal-margin = 0;
        selection-border-size = 0;
        show-workspace-indicator = false;
        vertical-margin = 0;
        vertical-margin-bottom = 0;
        window-gap = 8;
      };
      "org/gnome/shell/extensions/paperwm/keybindings" = {
        barf-out = [ "<Shift><Super>o" ];
        barf-out-active = [ "<Super>o" ];
        move-down = [ "<Shift><Super>Down" ];
        move-left = [
          "<Shift><Super>comma"
          "<Shift><Super>Left"
        ];
        move-right = [
          "<Shift><Super>period"
          "<Shift><Super>Right"
        ];
        move-up = [ "<Shift><Super>Up" ];
        new-window = [ "<Super>n" ];
        paper-toggle-fullscreen = [ "" ];
        switch-down-workspace = [ "" ];
        switch-monitor-down = [ "<Control><Super>Down" ];
        switch-monitor-left = [ "<Control><Super>Left" ];
        switch-monitor-right = [ "<Control><Super>Right" ];
        switch-monitor-up = [ "<Control><Super>Up" ];
        switch-up-workspace = [ "" ];
        toggle-maximize-width = [ "" ];
      };
      "org/gnome/desktop/wm/keybindings/switch-to-workspace-right" = {
        switch-to-workspace-right = [ "<Super>Page_Down" ];
        switch-to-workspace-left = [ "<Super>Page_Up" ];
      };
    };
  };
}
