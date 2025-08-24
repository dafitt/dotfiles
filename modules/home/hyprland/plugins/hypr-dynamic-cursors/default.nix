{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.hyprland.plugins.hypr-dynamic-cursors;
in
{
  options.dafitt.hyprland.plugins.hypr-dynamic-cursors = with types; {
    enable = mkEnableOption "hypr-dynamic-cursors";

    mode = mkOpt (enum [
      "rotate"
      "tilt"
      "stretch"
    ]) "stretch" "Cursor rotation mode.";
  };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      # https://github.com/VirtCode/hypr-dynamic-cursors
      plugins = [ pkgs.hyprlandPlugins.hypr-dynamic-cursors ];

      # https://github.com/VirtCode/hypr-dynamic-cursors/tree/inverted?tab=readme-ov-file#configuration
      extraConfig = ''
        plugin:dynamic-cursors {
          enabled = true

          mode = ${cfg.mode}
          rotate:length = ${toString config.stylix.cursor.size}

          shake:enabled = false
        }
      '';
    };
  };
}
