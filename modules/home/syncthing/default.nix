{ options, config, lib, pkgs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.syncthing;
in
{
  options.dafitt.syncthing = with types; {
    enable = mkBoolOpt (osConfig.dafitt.networking.firewall.allowSyncthing or false) "Whether to enable syncthing, a tool to sync files with other devices.";
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
