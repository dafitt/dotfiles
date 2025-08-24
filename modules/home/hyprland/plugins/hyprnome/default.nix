{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.hyprland.plugins.hyprnome;
in
{
  options.dafitt.hyprland.plugins.hyprnome = with types; {
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
  # - modules/home/desktops/hyprland/default.nix: bind
  # - modules/home/desktops/hyprland/plugins/default.nix: assertions
}
