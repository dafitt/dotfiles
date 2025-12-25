{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dafitt.desktopEnvironment-hyprland.animated-background;
in
{
  options.dafitt.desktopEnvironment-hyprland.animated-background = {
    enable = mkEnableOption "animated background";
  };

  config = mkIf cfg.enable {
    dafitt.desktopEnvironment-hyprland.plugins.hyprwinwrap.enable = true;

    # https://sw.kovidgoyal.net/kitty/overview/#startup-sessions
    #$ kitty --session wallpaper
    xdg.configFile."kitty/wallpaper".text = ''
      os_window_class wallpaper

      layout fat:bias=66;full_size=2;mirrored=true
      launch ${config.programs.cava.package}/bin/cava
      launch ${config.programs.btop.package}/bin/btop --preset 1 --update 3500
      launch ${pkgs.asciiquarium}/bin/asciiquarium
      launch ${pkgs.peaclock}/bin/peaclock
      launch ${pkgs.asciiquarium}/bin/asciiquarium
    '';

    systemd.user.services."hyprland-animated-background" = {
      Unit = {
        Description = "animated background";
        ConditionEnvironment = "WAYLAND_DISPLAY";
        After = [ config.wayland.systemd.target ];
        PartOf = [ config.wayland.systemd.target ];
        X-Restart-Triggers = [ "${config.xdg.configFile."kitty/wallpaper".source}" ];
      };
      Service = {
        Environment = [
          "PATH=/run/current-system/sw/bin"
          "KITTY_DISABLE_WAYLAND=1" # https://github.com/hyprwm/hyprland-plugins/issues/177
        ];
        ExecCondition = ''${pkgs.systemd}/lib/systemd/systemd-xdg-autostart-condition "Hyprland" ""'';
        ExecStart = "${config.programs.kitty.package}/bin/kitty --session wallpaper --override background_opacity=0";
        Restart = "always";
      };
      Install.WantedBy = [ config.wayland.systemd.target ];
    };
  };
}
