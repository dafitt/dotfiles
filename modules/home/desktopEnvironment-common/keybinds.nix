{ lib, pkgs, ... }:
with lib;
let
  quickPoweroff = "${pkgs.systemd}/bin/systemctl poweroff";
  quickReboot = "${pkgs.systemd}/bin/systemctl reboot";
  quickSleep = "${pkgs.systemd}/bin/systemctl sleep";

  audioMute = "${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
  audioRaiseVolume = "${pkgs.wireplumber}/bin/wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 2%+";
  audioLowerVolume = "${pkgs.wireplumber}/bin/wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 2%-";
  micMute = "${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
  micRaiseVolume = "${pkgs.wireplumber}/bin/wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SOURCE@ 4%+";
  micLowerVolume = "${pkgs.wireplumber}/bin/wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SOURCE@ 4%-";
  monBrightnessUp = "${getExe pkgs.brightnessctl} --exponent s 5%+";
  monBrightnessDown = "${getExe pkgs.brightnessctl} --exponent s 5%-";
  kbdBrightnessUp = "${getExe pkgs.brightnessctl} --device='*::kbd_backlight' s 10%+";
  kbdBrightnessDown = "${getExe pkgs.brightnessctl} --device='*::kbd_backlight' s 10%-";
in
{
  wayland.windowManager.hyprland.settings = {
    bind = [
      "Super&Control, ADIAERESIS, exec, ${quickPoweroff}"
      "Super&Control, ODIAERESIS, exec, ${quickReboot}"
      "Super, UDIAERESIS, exec, ${quickSleep}"

      ", XF86AudioMute, exec, ${audioMute}"
      "ALT, XF86AudioMute, exec, ${micMute}"
      ", XF86AudioMicMute, exec, ${micMute}"
    ];
    # Bind: repeat while holding
    binde = [
      ", XF86AudioRaiseVolume, exec, ${audioRaiseVolume}"
      ", XF86AudioLowerVolume, exec, ${audioLowerVolume}"
      "ALT, XF86AudioRaiseVolume, exec, ${micRaiseVolume}"
      "ALT, XF86AudioLowerVolume, exec, ${micLowerVolume}"
      ", XF86MonBrightnessUp, exec, ${monBrightnessUp}"
      ", XF86MonBrightnessDown, exec, ${monBrightnessDown}"
      ", XF86KbdBrightnessUp, exec, ${kbdBrightnessUp}"
      ", XF86KbdBrightnessDown, exec, ${kbdBrightnessDown}"
    ];
  };

  programs.niri.settings.binds = {
    "Mod+Control+Adiaeresis".action.spawn-sh = quickPoweroff;
    "Mod+Control+Odiaeresis".action.spawn-sh = quickReboot;
    "Mod+Udiaeresis".action.spawn-sh = quickSleep;

    "XF86AudioMute".action.spawn-sh = audioMute;
    "Alt+XF86AudioMute".action.spawn-sh = micMute;
    "XF86AudioMicMute".action.spawn-sh = micMute;
    "XF86AudioRaiseVolume".action.spawn-sh = audioRaiseVolume;
    "XF86AudioLowerVolume".action.spawn-sh = audioLowerVolume;
    "Alt+XF86AudioRaiseVolume".action.spawn-sh = micRaiseVolume;
    "Alt+XF86AudioLowerVolume".action.spawn-sh = micLowerVolume;
    "XF86MonBrightnessUp".action.spawn-sh = monBrightnessUp;
    "XF86MonBrightnessDown".action.spawn-sh = monBrightnessDown;
    "XF86KbdBrightnessUp".action.spawn-sh = kbdBrightnessUp;
    "XF86KbdBrightnessDown".action.spawn-sh = kbdBrightnessDown;
  };
}
