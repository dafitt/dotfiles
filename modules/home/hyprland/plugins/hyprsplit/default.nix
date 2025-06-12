{ config, lib, pkgs, inputs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.hyprland.plugins.hyprsplit;
in
{
  options.dafitt.hyprland.plugins.hyprsplit = with types; {
    enable = mkEnableOption "hyprsplit";
  };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      # https://github.com/shezdy/hyprsplit
      plugins = [ pkgs.hyprlandPlugins.hyprsplit ];

      settings.bind = [
        "SUPER, H, split:swapactiveworkspaces, current +1"
        "SUPER, G, split:grabroguewindows"

        # Workspace control
        "SUPER, 1, split:workspace, 1"
        "SUPER, 2, split:workspace, 2"
        "SUPER, 3, split:workspace, 3"
        "SUPER, 4, split:workspace, 4"
        "SUPER, 5, split:workspace, 5"
        "SUPER, 6, split:workspace, 6"
        "SUPER, 7, split:workspace, 7"
        "SUPER, 8, split:workspace, 8"
        "SUPER, 9, split:workspace, 9"
        "SUPER, 0, split:workspace, 10"
        "SUPER, D, split:workspace, name:D" # desktop only
        "SUPER, code:87, split:workspace, 1" # Numpad
        "SUPER, code:88, split:workspace, 2" # Numpad
        "SUPER, code:89, split:workspace, 3" # Numpad
        "SUPER, code:83, split:workspace, 4" # Numpad
        "SUPER, code:84, split:workspace, 5" # Numpad
        "SUPER, code:85, split:workspace, 6" # Numpad
        "SUPER, code:79, split:workspace, 7" # Numpad
        "SUPER, code:80, split:workspace, 8" # Numpad
        "SUPER, code:81, split:workspace, 9" # Numpad
        "SUPER, code:91, split:workspace, 10" # Numpad
        "SUPER, code:86, split:workspace, +1" # Numpad +
        "SUPER, code:82, split:workspace, -1" # Numpad -
        "SUPER, backspace, split:workspace, previous"
        "SUPER, mouse_down, split:workspace, -1"
        "SUPER, mouse_up, split:workspace, +1"

        # Move active window to a workspace
        "SUPER_SHIFT, 1, split:movetoworkspacesilent, 1"
        "SUPER_SHIFT, 2, split:movetoworkspacesilent, 2"
        "SUPER_SHIFT, 3, split:movetoworkspacesilent, 3"
        "SUPER_SHIFT, 4, split:movetoworkspacesilent, 4"
        "SUPER_SHIFT, 5, split:movetoworkspacesilent, 5"
        "SUPER_SHIFT, 6, split:movetoworkspacesilent, 6"
        "SUPER_SHIFT, 7, split:movetoworkspacesilent, 7"
        "SUPER_SHIFT, 8, split:movetoworkspacesilent, 8"
        "SUPER_SHIFT, 9, split:movetoworkspacesilent, 9"
        "SUPER_SHIFT, 0, split:movetoworkspacesilent, 10"
        "SUPER_SHIFT, code:87, split:movetoworkspacesilent, 1" # Numpad
        "SUPER_SHIFT, code:88, split:movetoworkspacesilent, 2" # Numpad
        "SUPER_SHIFT, code:89, split:movetoworkspacesilent, 3" # Numpad
        "SUPER_SHIFT, code:83, split:movetoworkspacesilent, 4" # Numpad
        "SUPER_SHIFT, code:84, split:movetoworkspacesilent, 5" # Numpad
        "SUPER_SHIFT, code:85, split:movetoworkspacesilent, 6" # Numpad
        "SUPER_SHIFT, code:79, split:movetoworkspacesilent, 7" # Numpad
        "SUPER_SHIFT, code:80, split:movetoworkspacesilent, 8" # Numpad
        "SUPER_SHIFT, code:81, split:movetoworkspacesilent, 9" # Numpad
        "SUPER_SHIFT, code:91, split:movetoworkspacesilent, 10" # Numpad
        "SUPER_SHIFT, code:86, split:movetoworkspacesilent, +1" # Numpad +
        "SUPER_SHIFT, code:82, split:movetoworkspacesilent, -1" # Numpad -
      ];
    };
  };

  # code traces in:
  # - modules/home/desktops/hyprland/default.nix: bind
  # - modules/home/desktops/hyprland/plugins/default.nix: assertions
}
