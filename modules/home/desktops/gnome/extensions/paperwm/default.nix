{ options, config, lib, pkgs, inputs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.desktops.gnome.extensions.paperwm;
in
{
  options.dafitt.desktops.gnome.extensions.paperwm = with types; {
    enable = mkBoolOpt config.dafitt.desktops.gnome.extensions.enable "Enable Gnome extension 'paperwm'.";
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
        new-window = [ "<Super>n" ];
        toggle-maximize-width = [ "" ];
        paper-toggle-fullscreen = [ "" ];
        barf-out = [ "<Shift><Super>o" ];
        barf-out-active = [ "<Super>o" ];
      };
    };
  };
}
