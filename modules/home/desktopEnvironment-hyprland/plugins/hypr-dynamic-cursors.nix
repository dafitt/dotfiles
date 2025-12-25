{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dafitt.desktopEnvironment-hyprland.plugins.hypr-dynamic-cursors;
in
{
  imports = with inputs; [
    self.homeModules.stylix
  ];

  options.dafitt.desktopEnvironment-hyprland.plugins.hypr-dynamic-cursors = with types; {
    enable = mkEnableOption "hypr-dynamic-cursors";

    mode = mkOption {
      type = enum [
        "rotate"
        "tilt"
        "stretch"
      ];
      default = "stretch";
      description = "Cursor rotation mode.";
    };
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
