{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.hyprland.themes.custom2023.swayosd;
in
{
  options.dafitt.hyprland.themes.custom2023.swayosd = with types; {
    enable = mkBoolOpt false "Whether to enable swayosd for hyprland.";
  };

  config = mkIf cfg.enable {
    # https://github.com/ErikReider/SwayOSD
    services.swayosd.enable = true;

    wayland.windowManager.hyprland.settings = {
      bind = [
        ", XF86AudioMute, exec, ${config.services.swayosd.package}/bin/swayosd-client --output-volume mute-toggle"
        "ALT, XF86AudioMute, exec, ${config.services.swayosd.package}/bin/swayosd-client --input-volume mute-toggle"
        ", XF86AudioMicMute, exec, ${config.services.swayosd.package}/bin/swayosd-client --input-volume mute-toggle"
        ", Caps_Lock, exec, ${config.services.swayosd.package}/bin/swayosd-client --caps-lock"
      ];
      binde = [
        ", XF86AudioRaiseVolume, execr, ${config.services.swayosd.package}/bin/swayosd-client --output-volume raise"
        ", XF86AudioLowerVolume, execr, ${config.services.swayosd.package}/bin/swayosd-client --output-volume lower"
        "ALT, XF86AudioRaiseVolume, exec, ${config.services.swayosd.package}/bin/swayosd-client --input-volume raise"
        "ALT, XF86AudioLowerVolume, exec, ${config.services.swayosd.package}/bin/swayosd-client --input-volume lower"
        ", XF86MonBrightnessUp, exec, ${config.services.swayosd.package}/bin/swayosd-client --brightness raise"
        ", XF86MonBrightnessDown, exec, ${config.services.swayosd.package}/bin/swayosd-client --brightness lower"
      ];
      # NOTE swayosd is also used in waybar pulseaudio plugin!
    };
  };
}
