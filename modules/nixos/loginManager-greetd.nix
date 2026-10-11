{ lib, pkgs, ... }:
with lib;
{
  #meta.doc = builtins.toFile "doc.md" "Enables and configures the greetd login manager.";

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
          "--background matrix"
          "--matrix-colors 'green,green,green'"
          "--matrix-length '5,17'"
          "--matrix-speed '0.20,0.80'"
        ];
        user = "greeter";
      };
    };
  };
}
