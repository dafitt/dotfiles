{ config, lib, options, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.desktops.common.syncthing;
in
{
  options.custom.desktops.common.syncthing = with types; {
    enable = mkBoolOpt config.custom.desktops.common.enable "Enable syncthing, a tool to sync files with other devices";
  };

  config = mkIf cfg.enable {
    # https://syncthing.net/
    home.packages = with pkgs; [ syncthing ];

    wayland.windowManager.hyprland.settings = {
      bind = [ "ALT SUPER, Z, exec, xdg-open https://localhost:8384" ];
      exec-once = [ "${pkgs.syncthing}/bin/syncthing serve --no-browser" ];
    };
  };
}
