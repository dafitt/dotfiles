{ options, config, lib, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.desktops.hyprland.mako;
  hyprlandCfg = config.wayland.windowManager.hyprland;
in
{
  options.custom.desktops.hyprland.mako = with types; {
    enable = mkBoolOpt config.custom.desktops.hyprland.enable "Enable mako for hyprland";
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.libnotify ];

    # notification daemon
    #$ man 5 mako
    services.mako = {
      enable = true;
      anchor = "bottom-right";
      margin = "0,48,48";
      borderRadius = hyprlandCfg.settings.decoration.rounding;
      borderSize = hyprlandCfg.settings.general.border_size;
      defaultTimeout = 5000;
      maxVisible = 10;
      format = "%a\\n%s\\n%b";
      sort = "+time";
    };
  };
}
