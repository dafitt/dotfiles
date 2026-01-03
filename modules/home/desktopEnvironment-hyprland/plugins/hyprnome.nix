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
        "Super, 1, exec, ${pkgs.hyprnome}/bin/hyprnome --previous"
        "Super, 2, exec, ${pkgs.hyprnome}/bin/hyprnome"
        "Super&Shift, 1, exec, ${pkgs.hyprnome}/bin/hyprnome --previous --move"
        "Super&Shift, 2, exec, ${pkgs.hyprnome}/bin/hyprnome --move"
      ];
    };
  };

  # code traces in:
  # - hyprland/default.nix: bind
  # - hyprland/plugins.nix: assertions
}
