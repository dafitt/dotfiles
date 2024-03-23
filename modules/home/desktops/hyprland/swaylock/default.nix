# TODO: 24.05 replace with hyprlock
{ options, config, lib, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.desktops.hyprland.swaylock;
in
{
  options.custom.desktops.hyprland.swaylock = with types; {
    enable = mkBoolOpt false "Enable swaylock for hyprland";
  };

  config = mkIf cfg.enable {
    # Screen locker for Wayland
    # https://github.com/swaywm/swaylock
    programs.swaylock = {
      enable = true;
      package = pkgs.swaylock-effects;

      settings = {
        # https://man.archlinux.org/man/swaylock.1
        daemonize = true;
        ignore-empty-password = true;

        # dont unlock with --grace
        grace-no-mouse = true;
        grace-no-touch = true;

        # Display an idle indicator
        indicator = true;
        indicator-idle-visible = true;
        indicator-radius = 200; # TODO: get screen size and do /5 or similar
        indicator-thickness = 30;
        font = config.stylix.fonts.monospace.name;
        line-uses-inside = true;

        clock = true;
        timestr = "%H:%M";
        datestr = "%y-%m-%d:%a";

        show-failed-attempts = true;

        # background
        screenshots = true;
        effect-pixelate = "64";
        effect-vignette = "0.7:0.9";
        fade-in = 1;
      };
    };

    wayland.windowManager.hyprland.settings.bind = [
      "SUPER, L, exec, ${config.programs.swaylock.package}/bin/swaylock --grace 2" # Lock the screen
    ];
  };
}