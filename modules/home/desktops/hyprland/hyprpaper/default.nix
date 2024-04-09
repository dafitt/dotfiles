{ options, config, lib, pkgs, inputs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.desktops.hyprland.hyprpaper;
in
{
  options.dafitt.desktops.hyprland.hyprpaper = with types; {
    enable = mkBoolOpt config.dafitt.desktops.hyprland.enable "Enable hyprpaper";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ inputs.hyprpaper.packages.${system}.default ];

    # https://github.com/hyprwm/hyprpaper/blob/main/nix/hm-module.nix
    services.hyprpaper = {
      enable = true;
      ipc = false;
      preloads = [ "${config.stylix.image}" ];
      wallpapers = [ ",${config.stylix.image}" ];
    };

    # fix for hyprpaper not starting
    systemd.user.services.hyprpaper.Install.WantedBy = mkForce [ "hyprland-session.target" ];
  };
}
