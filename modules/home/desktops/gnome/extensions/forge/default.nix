{ options, config, lib, pkgs, inputs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.desktops.gnome.extensions.forge;
in
{
  options.dafitt.desktops.gnome.extensions.forge = with types; {
    enable = mkBoolOpt config.dafitt.desktops.gnome.extensions.enable "Whether to enable Gnome extension 'forge'.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs.gnomeExtensions; [ forge ];

    dconf.settings = {
      "org/gnome/shell/extensions/forge" = {
        auto-split-enabled = true;
        dnd-center-layout = "swap";
        float-always-on-top-enabled = true;
        focus-border-toggle = false;
        move-pointer-focus-enabled = false;
        preview-hint-enabled = true;
        quick-settings-enabled = true;
        stacked-tiling-mode-enabled = false;
        tabbed-tiling-mode-enabled = false;
        window-gap-hidden-on-single = true;
        window-gap-size = 6;
      };
      "org/gnome/shell/extensions/forge/keybindings" = {
        con-split-vertical = [ ];
        focus-border-toggle = [ "<Control><Super>b" ];
        prefs-open = [ "<Control><Super>Period" ];
        prefs-tiling-toggle = [ "<Control><Super>w" ];
        window-focus-down = [ "<Super>Down" ];
        window-focus-left = [ "<Super>Left" ];
        window-focus-right = [ "<Super>Right" ];
        window-focus-up = [ "<Super>Up" ];
        window-move-down = [ "<Shift><Super>Down" ];
        window-move-left = [ "<Shift><Super>Left" ];
        window-move-right = [ "<Shift><Super>Right" ];
        window-move-up = [ "<Shift><Super>Up" ];
        window-resize-bottom-increase = [ "<Control><Super>Up" ];
        window-swap-down = [ ];
        window-swap-last-active = [ ];
        window-swap-left = [ ];
        window-swap-right = [ ];
        window-swap-up = [ ];
        window-toggle-always-float = [ "<Shift><Super>v" ];
        window-toggle-float = [ "<Super>v" ];
      };
      "org/gnome/mutter/keybindings" = {
        toggle-tiled-left = [ ];
        toggle-tiled-right = [ ];
      };
    };
  };
}
