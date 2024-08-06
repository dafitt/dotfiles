{ options, config, lib, pkgs, inputs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.desktops.gnome.extensions.forge;
in
{
  options.dafitt.desktops.gnome.extensions.forge = with types; {
    enable = mkBoolOpt config.dafitt.desktops.gnome.extensions.enable "Enable Gnome extension 'forge'.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs.gnomeExtensions; [ forge ];

    dconf.settings = {
      "org/gnome/shell" = {
        enabled-extensions = [ "forge@jmmaranan.com" ];
      };
      "org/gnome/shell/extensions/forge" = {
        stacked-tiling-mode-enabled = false;
        tabbed-tiling-mode-enabled = false;
        window-gap-hidden-on-single = true;
      };
      "org/gnome/shell/extensions/forge/keybindings" = {
        focus-border-toggle = [ "<Control><Super>b" ];
        window-focus-down = [ "<Super>Down" ];
        window-focus-left = [ "<Super>Left" ];
        window-focus-right = [ "<Super>Right" ];
        window-focus-up = [ "<Super>Up" ];
        window-move-down = [ "<Shift><Super>Down" ];
        window-move-left = [ "<Shift><Super>Left" ];
        window-move-right = [ "<Shift><Super>Right" ];
        window-move-up = [ "<Shift><Super>Up" ];
        window-resize-bottom-increase = [ "<Control><Super>Up" ];
      };
    };
  };
}
