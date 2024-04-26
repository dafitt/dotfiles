{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.desktops.hyprland.pyprland;
in
{
  options.dafitt.desktops.hyprland.pyprland = with types; {
    enable = mkBoolOpt config.dafitt.desktops.hyprland.enable "Enable pyprland an hyperland plugin system";
    scratchpads = mkBoolOpt cfg.enable "Enable the scratchpads plugin";
    magnify = mkBoolOpt cfg.enable "Enable the magnify plugin";
  };

  config = mkIf cfg.enable {
    # https://github.com/hyprland-community/pyprland
    home.packages = [ pkgs.pyprland ];

    systemd.user.services.pyprland = {
      Unit = {
        Description = "Helper tool for Hyprland";
        PartOf = [ "hyprland-session.target" ];
        After = [ "hyprland-session.target" ];
        ConditionEnvironment = "WAYLAND_DISPLAY";
      };
      Service = {
        Type = "simple";
        ExecStart = "${pkgs.pyprland}/bin/pypr";
        ExecStop = "${pkgs.bash}/bin/bash -c 'rm /tmp/hypr/*/.pyprland.sock'";
        Restart = "always";
      };
      Install = {
        WantedBy = [ "hyprland-session.target" ];
      };
    };

    xdg.configFile."hypr/pyprland.toml".source = (pkgs.formats.toml { }).generate "pyprland.toml" {
      # https://github.com/hyprland-community/pyprland/wiki/Getting-started
      pyprland.plugins =
        #optionals cfg.scratchpads [ "scratchpads" ] ++
        optionals cfg.magnify [ "magnify" ];

      #scratchpads.term = {
      #  animation = "fromTop";
      #  command = "kitty --class kitty-dropterm";
      #  class = "kitty-dropterm";
      #  size = "75% 60%";
      #  max_size = "100% 100%";
      #  margin = 50;
      #};
      #scratchpads.volume = {
      #  animation = "fromRight";
      #  command = "pavucontrol";
      #  class = "pavucontrol";
      #  size = "40% 70%";
      #  unfocus = "hide";
      #  lazy = true;
      #};
    };

    wayland.windowManager.hyprland.settings = {
      bind = optionals cfg.magnify [
        "SUPER , Z, exec, pypr zoom 2" # TODO 24.04: pypr zoom ++0.5
        "SUPER_SHIFT, Z, exec, pypr zoom"
        # TODO 24.04: "SUPER_ALT, mouse_down, exec, pypr zoom --0.5"
        # TODO 24.04: "SUPER_ALT, mouse_up, exec, pypr zoom ++0.5"
      ];
    };
  };
}
