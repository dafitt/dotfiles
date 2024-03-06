{ config, lib, options, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.desktops.hyprland.mako;
in
{
  options.custom.desktops.hyprland.mako = with types; {
    enable = mkBoolOpt config.custom.desktops.hyprland.enable "Enable mako for hyprland";
  };

  config = mkIf cfg.enable {
    # notification daemon
    # options $ man 5 mako
    services.mako = {
      enable = true;
      anchor = "bottom-right";
      borderRadius = config.wayland.windowManager.hyprland.settings.decoration.rounding;
      borderSize = config.wayland.windowManager.hyprland.settings.general.border_size;
      defaultTimeout = 30;
      format = "%a\\n%s\\n%b";
      sort = "+time";
      layer = "overlay";
    };
  };
}
