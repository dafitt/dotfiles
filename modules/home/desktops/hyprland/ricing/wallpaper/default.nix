{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.ricing.wallpaper;
in
{
  options.dafitt.ricing.wallpaper = with types; {
    enable = mkBoolOpt config.dafitt.desktops.hyprland.ricing.enable "Enable wallpaper ricing";
  };

  config = mkIf cfg.enable {
    dafitt.desktops.hyprland.plugins.hyprwinwrap.enable = true;

    # https://sw.kovidgoyal.net/kitty/overview/#startup-sessions
    xdg.configFile."kitty/wallpaper".text = ''
      os_window_class wallpaper

      layout fat:bias=66;full_size=2;mirrored=true
      launch ${pkgs.cava}/bin/cava
      launch ${config.programs.btop.package}/bin/btop --preset 1
      launch ${pkgs.asciiquarium}/bin/asciiquarium
      launch ${pkgs.peaclock}/bin/peaclock
      launch ${pkgs.asciiquarium}/bin/asciiquarium
    '';

    wayland.windowManager.hyprland.settings.exec-once = [
      "${config.programs.kitty.package}/bin/kitty --session wallpaper --override background_opacity=0"
    ];
  };
}
