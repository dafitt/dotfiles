{ config, pkgs, ... }: {

  # Screen locker for Wayland
  # https://github.com/swaywm/swaylock
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;

    settings = {
      # <https://man.archlinux.org/man/swaylock.1>
      submit-on-touch = true;
      ignore-empty-password = true;
      show-failed-attempts = true;

      # Take a screenshot of the current desktop
      screenshots = true;

      # Display an idle indicator
      indicator = true;
      indicator-idle-visible = true;
      indicator-radius = 200; # TODO get screen size and do /12 or similar
      indicator-thickness = 30;
      font = "${config.stylix.fonts.monospace.name}";
      line-uses-inside = true;

      # Display the current time
      clock = true;
      timestr = "%H:%M";
      #datestr = "%a, %d %b %y";
      datestr = "%y-%m-%d:%a";

      # background
      effect-pixelate = "64";
      effect-vignette = "0.7:0.9";
      fade-in = 1;

      # dont require passwort the first seconds
      grace = 2;
      grace-no-mouse = true;
      grace-no-touch = true;
    };
  };

  services.swayidle = {
    enable = true;
    systemdTarget = "hyprland-session.target";
    # options <https://github.com/swaywm/swayidle/blob/master/swayidle.1.scd>
    timeouts = [
      { timeout = 360; command = "${config.programs.swaylock.package}/bin/swaylock --daemonize"; }
      { timeout = 600; command = "${pkgs.systemd}/bin/systemctl suspend"; }
    ];
    events = [
      { event = "before-sleep"; command = "${config.programs.swaylock.package}/bin/swaylock --daemonize --fade-in 0"; }
    ];
  };

  wayland.windowManager.hyprland.settings = {
    bind = [
      "SUPER, L, exec, swaylock" # Lock the screen
    ];
  };
}
