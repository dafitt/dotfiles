{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.desktops.common.syncthing;
in
{
  options.dafitt.desktops.common.syncthing = with types; {
    enable = mkBoolOpt config.dafitt.desktops.common.enable "Enable syncthing, a tool to sync files with other devices";
  };

  config = mkIf cfg.enable {
    # https://syncthing.net/
    home.packages = with pkgs; [ syncthing ];

    wayland.windowManager.hyprland.settings = {
      bind = [ "SUPER_ALT, Z, exec, xdg-open https://localhost:8384" ];
      exec-once = [ "${pkgs.syncthing}/bin/syncthing serve --no-browser" ];
    };
  };
}
