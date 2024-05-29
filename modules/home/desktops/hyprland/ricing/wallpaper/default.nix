{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.ricing.wallpaper;
in
{
  options.dafitt.ricing.wallpaper = with types; {
    enable = mkBoolOpt config.dafitt.desktops.hyprland.ricing.enable "Enable wallpaper ricing.";
  };

  config = mkIf cfg.enable {
    dafitt.desktops.hyprland.plugins.hyprwinwrap.enable = true;

    # https://sw.kovidgoyal.net/kitty/overview/#startup-sessions
    #$ kitty --session wallpaper
    xdg.configFile."kitty/wallpaper".text = ''
      os_window_class wallpaper

      layout fat:bias=66;full_size=2;mirrored=true
      launch ${config.programs.cava.package}/bin/cava
      launch ${config.programs.btop.package}/bin/btop --preset 1
      launch ${pkgs.asciiquarium}/bin/asciiquarium
      launch ${pkgs.peaclock}/bin/peaclock
      launch ${pkgs.asciiquarium}/bin/asciiquarium
    '';

    systemd.user.services."hyprland-ricing-wallpaper" = {
      Unit = {
        Description = "ricing wallpaper";
        ConditionEnvironment = "WAYLAND_DISPLAY";
        After = [ "hyprland-session.target" ];
        PartOf = [ "hyprland-session.target" ];
        X-Restart-Triggers = [ "${config.xdg.configFile."kitty/wallpaper".source}" ];
      };
      Service = {
        Environment = [ "PATH=/run/current-system/sw/bin" ];
        ExecStart = "${config.programs.kitty.package}/bin/kitty --session wallpaper --override background_opacity=0";
        Restart = "always";
      };
      Install.WantedBy = [ "hyprland-session.target" ];
    };
  };
}
