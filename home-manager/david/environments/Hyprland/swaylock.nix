{ config, lib, pkgs, ... }: {

  options.services.swayidle.timeout = let inherit (lib) mkOption types; in {
    lock = mkOption {
      type = types.int;
      default = 360;
      description = ''
        The time in seconds after which the screen should be locked. 0 to disable.
      '';
    };
    suspend = mkOption {
      type = types.int;
      default = 600;
      description = ''
        The time in seconds after which the system should be suspended. 0 to disable.
      '';
    };
  };

  config = {
    # Screen locker for Wayland
    # https://github.com/swaywm/swaylock
    programs.swaylock = {
      enable = true;
      package = pkgs.swaylock-effects;

      settings = {
        # <https://man.archlinux.org/man/swaylock.1>
        ignore-empty-password = true;
        show-failed-attempts = true;

        # dont unlock with --grace
        grace-no-mouse = true;
        grace-no-touch = true;

        # Display an idle indicator
        indicator = true;
        indicator-idle-visible = true;
        indicator-radius = 200; # TODO get screen size and do /5 or similar
        indicator-thickness = 30;
        font = config.stylix.fonts.monospace.name;
        line-uses-inside = true;

        # Display the current time
        clock = true;
        timestr = "%H:%M";
        #datestr = "%a, %d %b %y";
        datestr = "%y-%m-%d:%a";

        # background
        screenshots = true;
        effect-pixelate = "64";
        effect-vignette = "0.7:0.9";
        fade-in = 1;
      };
    };

    services.swayidle = {
      enable = true;
      systemdTarget = "hyprland-session.target";
      # options <https://github.com/swaywm/swayidle/blob/master/swayidle.1.scd>
      timeouts = let timeout = config.services.swayidle.timeout; in [
        (lib.mkIf (timeout.lock > 0) { timeout = timeout.lock; command = "${config.programs.swaylock.package}/bin/swaylock --grace 30"; })
        (lib.mkIf (timeout.suspend > 0) { timeout = timeout.suspend; command = "${pkgs.systemd}/bin/systemctl suspend"; })
      ];
      events = [
        { event = "before-sleep"; command = "${config.programs.swaylock.package}/bin/swaylock --grace 0 --fade-in 0"; }
      ];
    };

    wayland.windowManager.hyprland.settings = {
      bind = [
        "SUPER, L, exec, swaylock --grace 2" # Lock the screen
      ];
    };
  };
}
