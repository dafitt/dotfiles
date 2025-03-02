{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.displayManager;
  enabledSubModules = filter (n: cfg.${n}.enable or false) (subtractLists [
    "sessionPaths"
  ]
    (attrNames cfg));
in
{
  options.dafitt.displayManager = with types; {
    sessionPaths = mkOption {
      description = "List of paths to search for session files.";
      type = listOf str;
      example = [
        "/run/current-system/sw/share/gnome-session/sessions"
        "/run/current-system/sw/share/wayland-sessions"

        "${config.services.displayManager.sessionData.desktops}/share/xsessions"
        "${config.services.displayManager.sessionData.desktops}/share/wayland-sessions"

        "${(pkgs.makeDesktopItem {
          name = "xorg-session";
          desktopName = "Xorg";
          exec = "${pkgs.xorg.xinit}/bin/startx";
        })}/share/applications"
      ];
      default = [ ];
    };
  };

  config = mkMerge [
    {
      assertions = [{
        assertion = length enabledSubModules <= 1;
        message = "${toString ./.}: Only one submodule can be enabled. Currently enabled: ${concatStringsSep ", " enabledSubModules}";
      }];
    }
    (mkIf (length enabledSubModules > 0) {
      dafitt.displayManager.sessionPaths = [
        "${(pkgs.makeDesktopItem {
        name = "bash-session";
        desktopName = "bash";
        exec = getExe pkgs.bash;
      })}/share/applications"

        "${config.services.displayManager.sessionData.desktops}/share/xsessions"
        "${config.services.displayManager.sessionData.desktops}/share/wayland-sessions"
      ];
    })
  ];
}
