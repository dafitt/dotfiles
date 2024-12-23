{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.displayManager.greetd;
in
{
  options.dafitt.displayManager.greetd = with types; {
    enable = mkBoolOpt (config.dafitt.displayManager.enable == "greetd") "Whether to enable greetd as the login/display manager.";
    sessionPaths = mkOption {
      description = "List of paths to search for session files.";
      type = listOf str;
      example = [
        "${config.services.xserver.displayManager.sessionData.desktops}/share/xsessions"
        "${config.services.xserver.displayManager.sessionData.desktops}/share/wayland-sessions"
        "/run/current-system/sw/share/xsessions"
        "/run/current-system/sw/share/wayland-sessions"
      ];
      default = [ ]; #NOTE Is set from the nixos/desktops-modules
    };
  };

  config = mkIf cfg.enable {
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = concatStringsSep " " [
            #$ nix run nixpkgs#greetd.tuigreet -- --help
            (getExe pkgs.greetd.tuigreet)
            "--time"
            "--remember"
            "--remember-user-session"
            "--sessions ${concatStringsSep ":" cfg.sessionPaths}"
            "--theme border=magenta;container=black;time=magenta;prompt=green;action=blue;button=yellow;text=cyan"
          ];
          user = "greeter";
        };
      };
    };

    # [Systemd error message gets printed over interface]https://github.com/apognu/tuigreet/issues/68
    # https://www.reddit.com/r/NixOS/comments/u0cdpi/tuigreet_with_xmonad_how/
    systemd.services.greetd.serviceConfig = {
      Type = "idle";
      StandardInput = "tty";
      StandardOutput = "tty";
      StandardError = "journal"; # Without this errors will spam on screen
      # Without these bootlogs will spam on screen
      TTYReset = true;
      TTYVHangup = true;
      TTYVTDisallocate = true;
    };
  };
}
