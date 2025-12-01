{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.displayManager.greetd;
in
{
  options.dafitt.displayManager.greetd = with types; {
    enable = mkEnableOption "greetd as the login/display manager";
  };

  config = mkIf cfg.enable {
    services.greetd = {
      enable = true;
      settings = rec {
        default_session = tuigreet_session;

        # https://github.com/apognu/tuigreet
        tuigreet_session = {
          command = concatStringsSep " " [
            #$ nix run nixpkgs#tuigreet -- --help
            (getExe pkgs.tuigreet)
            "--time"
            "--remember"
            "--remember-user-session"
            "--theme 'border=magenta;text=cyan;prompt=green;time=white;action=blue;button=yellow;container=black;input=red'"
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
