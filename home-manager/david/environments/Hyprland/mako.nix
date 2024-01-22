{ config, ... }: {

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
}
