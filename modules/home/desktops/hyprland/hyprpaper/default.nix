{ options, config, lib, pkgs, inputs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.desktops.hyprland.hyprpaper;
in
{
  options.dafitt.desktops.hyprland.hyprpaper = with types; {
    enable = mkBoolOpt config.dafitt.desktops.hyprland.enable "Whether to enable hyprpaper.";
  };

  config = mkIf cfg.enable {
    home.packages = [ config.services.hyprpaper.package ];

    # https://wiki.hyprland.org/Hypr-Ecosystem/hyprpaper/
    services.hyprpaper = {
      enable = true;
      settings = {
        ipc = false;
        splash = false;

        preload = [ "${config.stylix.image}" ];
        wallpaper = [ ",${config.stylix.image}" ];
      };
    };

    systemd.user.services.hyprpaper.Install.WantedBy = mkForce [ "hyprland-session.target" ];
  };
}
