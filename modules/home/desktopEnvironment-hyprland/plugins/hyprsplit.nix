{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dafitt.desktopEnvironment-hyprland.plugins.hyprsplit;
in
{
  options.dafitt.desktopEnvironment-hyprland.plugins.hyprsplit = {
    enable = mkEnableOption "hyprsplit";
  };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      # https://github.com/shezdy/hyprsplit
      plugins = [ pkgs.hyprlandPlugins.hyprsplit ];

      settings.bind = [
        "Super, H, split:swapactiveworkspaces, current +1"
        "Super, G, split:grabroguewindows"

        # Workspace control
        "Super, 1, split:workspace, 1"
        "Super, 2, split:workspace, 2"
        "Super, 3, split:workspace, 3"
        "Super, 4, split:workspace, 4"
        "Super, 5, split:workspace, 5"
        "Super, 6, split:workspace, 6"
        "Super, 7, split:workspace, 7"
        "Super, 8, split:workspace, 8"
        "Super, 9, split:workspace, 9"
        "Super, 0, split:workspace, 10"
        "Super, D, split:workspace, name:D" # desktop only
        "Super, code:87, split:workspace, 1" # Numpad
        "Super, code:88, split:workspace, 2" # Numpad
        "Super, code:89, split:workspace, 3" # Numpad
        "Super, code:83, split:workspace, 4" # Numpad
        "Super, code:84, split:workspace, 5" # Numpad
        "Super, code:85, split:workspace, 6" # Numpad
        "Super, code:79, split:workspace, 7" # Numpad
        "Super, code:80, split:workspace, 8" # Numpad
        "Super, code:81, split:workspace, 9" # Numpad
        "Super, code:91, split:workspace, 10" # Numpad
        "Super, code:86, split:workspace, +1" # Numpad +
        "Super, code:82, split:workspace, -1" # Numpad -
        "Super, backspace, split:workspace, previous"
        "Super, mouse_down, split:workspace, -1"
        "Super, mouse_up, split:workspace, +1"

        # Move active window to a workspace
        "Super&Shift, 1, split:movetoworkspacesilent, 1"
        "Super&Shift, 2, split:movetoworkspacesilent, 2"
        "Super&Shift, 3, split:movetoworkspacesilent, 3"
        "Super&Shift, 4, split:movetoworkspacesilent, 4"
        "Super&Shift, 5, split:movetoworkspacesilent, 5"
        "Super&Shift, 6, split:movetoworkspacesilent, 6"
        "Super&Shift, 7, split:movetoworkspacesilent, 7"
        "Super&Shift, 8, split:movetoworkspacesilent, 8"
        "Super&Shift, 9, split:movetoworkspacesilent, 9"
        "Super&Shift, 0, split:movetoworkspacesilent, 10"
        "Super&Shift, code:87, split:movetoworkspacesilent, 1" # Numpad
        "Super&Shift, code:88, split:movetoworkspacesilent, 2" # Numpad
        "Super&Shift, code:89, split:movetoworkspacesilent, 3" # Numpad
        "Super&Shift, code:83, split:movetoworkspacesilent, 4" # Numpad
        "Super&Shift, code:84, split:movetoworkspacesilent, 5" # Numpad
        "Super&Shift, code:85, split:movetoworkspacesilent, 6" # Numpad
        "Super&Shift, code:79, split:movetoworkspacesilent, 7" # Numpad
        "Super&Shift, code:80, split:movetoworkspacesilent, 8" # Numpad
        "Super&Shift, code:81, split:movetoworkspacesilent, 9" # Numpad
        "Super&Shift, code:91, split:movetoworkspacesilent, 10" # Numpad
        "Super&Shift, code:86, split:movetoworkspacesilent, +1" # Numpad +
        "Super&Shift, code:82, split:movetoworkspacesilent, -1" # Numpad -
      ];
    };
  };

  # code traces in:
  # - hyprland/default.nix: bind
  # - hyprland/plugins.nix: assertions
}
