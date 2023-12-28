{ config, lib, ... }: {
  services.swayosd.enable = true;

  wayland.windowManager.hyprland.settings = {
    exec-once = (lib.optionals config.services.swayosd.enable [ "${config.services.swayosd.package}/bin/swayosd" ]);

    bind = (lib.optionals config.services.swayosd.enable [
      ", XF86AudioMute, exec, ${config.services.swayosd.package}/bin/swayosd --output-volume mute-toggle && $XDG_CONFIG_HOME/eww/scripts/update_audioMute"
      "ALT, XF86AudioMute, exec, ${config.services.swayosd.package}/bin/swayosd --input-volume mute-toggle && $XDG_CONFIG_HOME/eww/scripts/update_microphoneMute"
      ", XF86AudioMicMute, exec, ${config.services.swayosd.package}/bin/swayosd --input-volume mute-toggle && $XDG_CONFIG_HOME/eww/scripts/update_microphoneMute"
      ", Caps_Lock, exec, ${config.services.swayosd.package}/bin/swayosd --caps-lock"
    ]);

    binde = (lib.optionals config.services.swayosd.enable [
      ", XF86AudioRaiseVolume, execr, ${config.services.swayosd.package}/bin/swayosd --output-volume raise && $XDG_CONFIG_HOME/eww/scripts/update_audioVolume"
      ", XF86AudioLowerVolume, execr, ${config.services.swayosd.package}/bin/swayosd --output-volume lower && $XDG_CONFIG_HOME/eww/scripts/update_audioVolume"
      "ALT, XF86AudioRaiseVolume, exec, ${config.services.swayosd.package}/bin/swayosd --input-volume raise && $XDG_CONFIG_HOME/eww/scripts/update_microphoneVolume"
      "ALT, XF86AudioLowerVolume, exec, ${config.services.swayosd.package}/bin/swayosd --input-volume lower && $XDG_CONFIG_HOME/eww/scripts/update_microphoneVolume"
      ", XF86MonBrightnessUp, exec, ${config.services.swayosd.package}/bin/swayosd --brightness raise && $XDG_CONFIG_HOME/eww/scripts/update_brightness"
      ", XF86MonBrightnessDown, exec, ${config.services.swayosd.package}/bin/swayosd --brightness lower && $XDG_CONFIG_HOME/eww/scripts/update_brightness"
    ]);
  };
}
