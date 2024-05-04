{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.desktops.hyprland.swayosd;
in
{
  options.dafitt.desktops.hyprland.swayosd = with types; {
    enable = mkBoolOpt config.dafitt.desktops.hyprland.enable "Enable swayosd for hyprland";
  };

  config = mkIf cfg.enable {
    services.swayosd.enable = true;

    wayland.windowManager.hyprland.settings = {
      exec-once = [ "${config.services.swayosd.package}/bin/swayosd" ];

      bind = [
        ", XF86AudioMute, exec, ${config.services.swayosd.package}/bin/swayosd --output-volume mute-toggle"
        "ALT, XF86AudioMute, exec, ${config.services.swayosd.package}/bin/swayosd --input-volume mute-toggle"
        ", XF86AudioMicMute, exec, ${config.services.swayosd.package}/bin/swayosd --input-volume mute-toggle"
        ", Caps_Lock, exec, ${config.services.swayosd.package}/bin/swayosd --caps-lock"
      ];

      binde = [
        ", XF86AudioRaiseVolume, execr, ${config.services.swayosd.package}/bin/swayosd --output-volume raise"
        ", XF86AudioLowerVolume, execr, ${config.services.swayosd.package}/bin/swayosd --output-volume lower"
        "ALT, XF86AudioRaiseVolume, exec, ${config.services.swayosd.package}/bin/swayosd --input-volume raise"
        "ALT, XF86AudioLowerVolume, exec, ${config.services.swayosd.package}/bin/swayosd --input-volume lower"
        ", XF86MonBrightnessUp, exec, ${config.services.swayosd.package}/bin/swayosd --brightness raise"
        ", XF86MonBrightnessDown, exec, ${config.services.swayosd.package}/bin/swayosd --brightness lower"
      ];

      # NOTE swayosd is also used in waybar pulseaudio plugin!
    };
  };
}
