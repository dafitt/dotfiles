{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.hyprland.pyprland;
in
{
  options.dafitt.hyprland.pyprland = with types; {
    enable = mkBoolOpt config.dafitt.hyprland.enable "Whether to enable pyprland an hyperland plugin system.";

    scratchpads = mkOption {
      description = ''
        Scratchpads configuration.

        NOTE: Additional keybinding configuration required:
        ```
        wayland.windowManager.hyprland.settings = {
          bind = optionals config.dafitt.hyprland.pyprland.enable
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
        "magnify" # https://hyprland-community.github.io/pyprland/magnify.html
        "scratchpads" # https://hyprland-community.github.io/pyprland/scratchpads.html
        "toggle_dpms" # https://hyprland-community.github.io/pyprland/toggle_dpms.html
        "toggle_special" # https://hyprland-community.github.io/pyprland/toggle_special.html
        "workspaces_follow_focus" # https://hyprland-community.github.io/pyprland/workspaces_follow_focus.html
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
        # toggle_dpms
        "SUPER, ODIAERESIS, exec, ${pkgs.pyprland}/bin/pypr toggle_dpms"
        # toggle_special (minimize windows)
        "SUPER, Y, exec, ${pkgs.pyprland}/bin/pypr toggle_special minimized" # move
        "SUPER_SHIFT, Y, togglespecialworkspace, minimized" # show
      ];
      bindn = [
        # scratchpads
        ", Escape, exec, ${pkgs.pyprland}/bin/pypr hide '*'"
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
        ExecStart = "${pkgs.pyprland}/bin/pypr";
        ExecStop = "${pkgs.bash}/bin/bash -c '${pkgs.coreutils}/bin/rm $XDG_RUNTIME_DIR/hypr/*/.pyprland.sock'";
        Restart = "on-failure";
        X-Restart-Triggers = [ "${config.xdg.configFile."hypr/pyprland.toml".source}" ];
      };
      Install.WantedBy = [ "hyprland-session.target" ];
    };
  };
}
