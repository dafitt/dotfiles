{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dafitt.desktopEnvironment-hyprland.plugins.hyprnome;
in
{
  options.dafitt.desktopEnvironment-hyprland.plugins.hyprnome = {
    enable = mkEnableOption "hyprnome; for GNOME-like workspace switching in Hyprland";
  };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      # https://github.com/donovanglover/hyprnome
      plugins = [ pkgs.hyprnome ];

      settings.bind = [
        "SUPER, 1, exec, ${pkgs.hyprnome}/bin/hyprnome --previous"
        "SUPER, 2, exec, ${pkgs.hyprnome}/bin/hyprnome"
        "SUPER_SHIFT, 1, exec, ${pkgs.hyprnome}/bin/hyprnome --previous --move"
        "SUPER_SHIFT, 2, exec, ${pkgs.hyprnome}/bin/hyprnome --move"
      ];
    };
  };

  # code traces in:
  # - hyprland/default.nix: bind
  # - hyprland/plugins.nix: assertions
}
