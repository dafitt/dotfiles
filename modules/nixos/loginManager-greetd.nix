{ lib, pkgs, ... }:
with lib;
{
  services.greetd = {
    enable = true;
    useTextGreeter = true;
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
}
