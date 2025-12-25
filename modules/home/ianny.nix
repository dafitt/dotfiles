{ config, pkgs, ... }:
{
  # https://github.com/zefr0x/ianny
  home.packages = with pkgs; [ ianny ];

  xdg.configFile."io.github.zefr0x.ianny/config.toml".source =
    (pkgs.formats.toml { }).generate "config.toml"
      {
        timer = {
          idle_timeout = 240;
          long_break_duration = 300;
          long_break_timeout = 3840;
          short_break_duration = 20;
          short_break_timeout = 1200;
        };
        notification = {
          show_progress_bar = false;
          minimum_update_delay = 2;
        };
      };

  systemd.user.services.ianny = {
    Unit = {
      Description = "Ianny break timer";
      After = [ "graphical-session-pre.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.ianny}/bin/ianny";
      X-Restart-Triggers = [ "${config.xdg.configFile."io.github.zefr0x.ianny/config.toml".source}" ];
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };

  #wayland.windowManager.hyprland.settings.exec-once = [ "uwsm app -- ${pkgs.ianny}/bin/ianny" ];
}
