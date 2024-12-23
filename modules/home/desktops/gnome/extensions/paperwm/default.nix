{ options, config, lib, pkgs, inputs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.desktops.gnome.extensions.paperwm;
in
{
  options.dafitt.desktops.gnome.extensions.paperwm = with types; {
    enable = mkBoolOpt config.dafitt.desktops.gnome.extensions.enable "Whether to enable Gnome extension 'paperwm'.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs.gnomeExtensions; [ paperwm ];

    dconf.settings = {
      "org/gnome/shell/extensions/paperwm" = {
        selection-border-size = 0;
        window-gap = 8;
        horizontal-margin = 0;
        vertical-margin = 0;
        vertical-margin-bottom = 0;
        show-workspace-indicator = false;
      };
      "org/gnome/shell/extensions/paperwm/keybindings" = {
        barf-out = [ "<Shift><Super>o" ];
        barf-out-active = [ "<Super>o" ];
        move-down = [ "<Shift><Super>Down" ];
        move-left = [ "<Shift><Super>comma" "<Shift><Super>Left" ];
        move-right = [ "<Shift><Super>period" "<Shift><Super>Right" ];
        move-up = [ "<Shift><Super>Up" ];
        new-window = [ "<Super>n" ];
        paper-toggle-fullscreen = [ "" ];
        switch-monitor-down = [ "<Control><Super>Down" ];
        switch-monitor-left = [ "<Control><Super>Left" ];
        switch-monitor-right = [ "<Control><Super>Right" ];
        switch-monitor-up = [ "<Control><Super>Up" ];
        toggle-maximize-width = [ "" ];
      };
    };
  };
}
