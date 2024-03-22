{ options, config, lib, pkgs, inputs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.desktops.hyprland.hyprpaper;
in
{
  options.custom.desktops.hyprland.hyprpaper = with types; {
    enable = mkBoolOpt config.custom.desktops.hyprland.enable "Enable hyprpaper";
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
  };
}
