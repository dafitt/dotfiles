{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.displayManager.greetd;
in
{
  options.dafitt.displayManager.greetd = with types; {
    enable = mkBoolOpt (config.dafitt.displayManager.enable == "greetd") "Whether to enable greetd as the login/display manager.";
  };

  config = mkIf cfg.enable {
    services.greetd = {
      enable = true;
      settings = rec {
        default_session = tuigreet_session;

        tuigreet_session = {
          command = concatStringsSep " " [
            #$ nix run nixpkgs#greetd.tuigreet -- --help
            (getExe pkgs.greetd.tuigreet)
            "--time"
            "--remember"
            "--remember-user-session"
            "--sessions '${concatStringsSep ":" config.dafitt.displayManager.sessionPaths}'"
            "--theme 'border=magenta;container=black;time=magenta;prompt=green;action=blue;button=yellow;text=cyan'"
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
