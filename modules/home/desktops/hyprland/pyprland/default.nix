{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.desktops.hyprland.pyprland;
in
{
  options.dafitt.desktops.hyprland.pyprland = with types; {
    enable = mkBoolOpt config.dafitt.desktops.hyprland.enable "Enable pyprland an hyperland plugin system.";
    scratchpads = mkBoolOpt cfg.enable "Enable the scratchpads plugin";
    magnify = mkBoolOpt cfg.enable "Enable the magnify plugin";
  };

  config = mkIf cfg.enable {
    #TODO upstream a pyprland nix module?
    # https://github.com/hyprland-community/pyprland
    home.packages = [ pkgs.pyprland ];
    dafitt.environment.btop.enable = mkIf cfg.scratchpads true;

    xdg.configFile."hypr/pyprland.toml".source = (pkgs.formats.toml { }).generate "pyprland.toml" {
      # https://github.com/hyprland-community/pyprland/wiki/Getting-started
      pyprland.plugins =
        optionals cfg.scratchpads [ "scratchpads" ] ++ # https://github.com/hyprland-community/pyprland/wiki/scratchpads
        optionals cfg.magnify [ "magnify" ]; # https://github.com/hyprland-community/pyprland/wiki/magnify

      #TODO when nix module is upstreamed move scratchpads configuration to its application module
      scratchpads.btop = {
        animation = "fromTop";
        command = "${config.home.sessionVariables.TERMINAL} --class btop ${config.programs.btop.package}/bin/btop";
        class = "btop";
        size = "90% 90%";
        margin = "2%";
        lazy = true;
      };
      #scratchpads.term = {
      #  animation = "fromTop";
      #  command = "${config.home.sessionVariables.TERMINAL} --class dropterm";
      #  class = "dropterm";
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
      bind =
        optionals cfg.scratchpads [
          "SUPER_ALT , P, exec, pypr toggle btop" #TODO upstream "*" support (hide all scratchpads with `ESC`)
          #  "SUPER_ALT , T, exec, pypr toggle term"
          #  "SUPER_ALT , A, exec, pypr toggle volume"
        ] ++
        optionals cfg.magnify [
          "SUPER, Z, exec, pypr zoom"
          "SUPER, minus, exec, pypr zoom --0.5"
          "SUPER, plus, exec, pypr zoom ++0.5"
          "SUPER_ALT, mouse_down, exec, pypr zoom ++0.5"
          "SUPER_ALT, mouse_up, exec, pypr zoom --0.5"
        ];
    };

    #TODO upstream systemd service unit
    systemd.user.services.pyprland = {
      Unit = {
        Description = "helper tool for Hyprland.";
        PartOf = [ "hyprland-session.target" ];
        After = [ "hyprland-session.target" ];
        ConditionEnvironment = "WAYLAND_DISPLAY";
      };
      Service = {
        Type = "simple";
        ExecStart = "${pkgs.pyprland}/bin/pypr";
        ExecStop = "${pkgs.bash}/bin/bash -c '${pkgs.coreutils}/bin/rm /tmp/.pypr-*/.pyprland.sock'";
        Restart = "always";
      };
      Install = {
        WantedBy = [ "hyprland-session.target" ];
      };
    };
  };
}
