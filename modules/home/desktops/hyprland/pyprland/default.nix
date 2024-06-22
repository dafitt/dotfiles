{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.desktops.hyprland.pyprland;
in
{
  options.dafitt.desktops.hyprland.pyprland = with types; {
    enable = mkBoolOpt config.dafitt.desktops.hyprland.enable "Enable pyprland an hyperland plugin system.";

    scratchpads = mkOption {
      description = ''
        Scratchpads configuration.

        NOTE: Additional keybinding configuration required:
        ```
        wayland.windowManager.hyprland.settings = {
          bind = optionals config.dafitt.desktops.hyprland.pyprland.enable
            [ "SUPER_ALT, P, exec, ${pkgs.pyprland}/bin/pypr toggle btop" ];
        };
        ```
      '';
      type = attrsOf anything;
      example = {
        btop = {
          animation = "fromTop";
          command = "${config.home.sessionVariables.TERMINAL} --class btop ${getExe config.programs.btop.package}";
          class = "btop";
          size = "90% 90%";
          margin = "2%";
          lazy = true;
        };
        pavucontrol = {
          animation = "fromRight";
          command = "${pkgs.pavucontrol}/bin/pavucontrol";
          class = "pavucontrol";
          size = "40% 70%";
          margin = "2%";
          unfocus = "hide";
          lazy = true;
        };
      };
      default = { };
    };
  };

  config = mkIf cfg.enable {
    #TODO upstream a pyprland nix module?
    # https://github.com/hyprland-community/pyprland
    home.packages = [ pkgs.pyprland ];

    xdg.configFile."hypr/pyprland.toml".source = (pkgs.formats.toml { }).generate "pyprland.toml" {
      # https://github.com/hyprland-community/pyprland/wiki/Getting-started
      pyprland.plugins = [
        "magnify" # https://github.com/hyprland-community/pyprland/wiki/magnify
        "scratchpads" #https://github.com/hyprland-community/pyprland/wiki/scratchpads
      ];

      scratchpads = cfg.scratchpads;
    };

    wayland.windowManager.hyprland.settings = {
      bind = [
        # magnify
        "SUPER, Z, exec, ${pkgs.pyprland}/bin/pypr zoom"
        "SUPER, minus, exec, ${pkgs.pyprland}/bin/pypr zoom --0.5"
        "SUPER, plus, exec, ${pkgs.pyprland}/bin/pypr zoom ++0.5"
        "SUPER_ALT, mouse_down, exec, ${pkgs.pyprland}/bin/pypr zoom ++0.5"
        "SUPER_ALT, mouse_up, exec, ${pkgs.pyprland}/bin/pypr zoom --0.5"
        "SUPER_ALT, mouse:274, exec, ${pkgs.pyprland}/bin/pypr zoom"
        # scratchpads
        #TODO pypr>=2.3.5: ", Escape, exec, ${pkgs.pyprland}/bin/pypr hide '*'"
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
        ExecStop = "${pkgs.bash}/bin/bash -c '${pkgs.coreutils}/bin/rm /run/user/%U/hypr/*/.pyprland.sock'";
        Restart = "on-failure";
        X-Restart-Triggers = [ "${config.xdg.configFile."hypr/pyprland.toml".source}" ];
      };
      Install.WantedBy = [ "hyprland-session.target" ];
    };
  };
}
