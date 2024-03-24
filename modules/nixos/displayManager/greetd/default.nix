{ options, config, lib, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.displayManager.greetd;
in
{
  options.custom.displayManager.greetd = with types; {
    enable = mkBoolOpt false "Enable greetd as the login/display manager";
    sessionPaths = mkOption {
      description = "List of paths to search for session files";
      type = listOf str;
      default = [ ]; # NOTE: is used in the desktops/ modules
      example = [
        "${config.services.xserver.displayManager.sessionData.desktops}/share/xsessions"
        "${config.services.xserver.displayManager.sessionData.desktops}/share/wayland-sessions"
        "/run/current-system/sw/share/xsessions"
        "/run/current-system/sw/share/wayland-sessions"
      ];
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
          ];
          user = "greeter";
        };
      };
    };
  };
}
