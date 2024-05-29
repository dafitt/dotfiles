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
        command = "${config.home.sessionVariables.TERMINAL} --class btop ${getExe config.programs.btop.package}";
        class = "btop";
        size = "90% 90%";
        margin = "2%";
        lazy = true;
      };
      scratchpads.kitty = {
        animation = "fromTop";
        command = "${config.programs.kitty.package}/bin/kitty --class dropterm --hold ${getExe config.programs.fastfetch.package}";
        class = "dropterm";
        size = "90% 90%";
        margin = "2%";
        lazy = true;
      };
      scratchpads.pavucontrol = {
        animation = "fromRight";
        command = "${pkgs.pavucontrol}/bin/pavucontrol";
        class = "pavucontrol";
        size = "40% 70%";
        margin = "2%";
        unfocus = "hide";
        lazy = true;
      };
    };

    wayland.windowManager.hyprland.settings = {
      bind =
        optionals cfg.scratchpads [
          #TODO pypr>=2.3.5: ", Escape, exec, ${pkgs.pyprland}/bin/pypr hide '*'"
          "SUPER_ALT, P, exec, ${pkgs.pyprland}/bin/pypr toggle btop"
          "SUPER_ALT, T, exec, ${pkgs.pyprland}/bin/pypr toggle kitty"
          "SUPER_ALT, A, exec, ${pkgs.pyprland}/bin/pypr toggle pavucontrol"
        ] ++
        optionals cfg.magnify [
          "SUPER, Z, exec, ${pkgs.pyprland}/bin/pypr zoom"
          "SUPER, minus, exec, ${pkgs.pyprland}/bin/pypr zoom --0.5"
          "SUPER, plus, exec, ${pkgs.pyprland}/bin/pypr zoom ++0.5"
          "SUPER_ALT, mouse_down, exec, ${pkgs.pyprland}/bin/pypr zoom ++0.5"
          "SUPER_ALT, mouse_up, exec, ${pkgs.pyprland}/bin/pypr zoom --0.5"
          "SUPER_ALT, mouse:274, exec, ${pkgs.pyprland}/bin/pypr zoom"
        ];
    };

    #TODO upstream systemd service unit
    systemd.user.services.pyprland = {
      Unit = {
        Description = "helper tool for Hyprland";
        PartOf = [ "hyprland-session.target" ];
        After = [ "hyprland-session.target" ];
        ConditionEnvironment = "WAYLAND_DISPLAY";
      };
      Service = {
        Type = "simple";
        ExecStart = "${pkgs.pyprland}/bin/pypr";
        ExecStop = "${pkgs.bash}/bin/bash -c '${pkgs.coreutils}/bin/rm /tmp/.pypr-*/.pyprland.sock'";
        Restart = "always";
        X-Restart-Triggers = [ "${config.xdg.configFile."hypr/pyprland.toml".source}" ];
      };
      Install.WantedBy = [ "hyprland-session.target" ];
    };
  };
}
