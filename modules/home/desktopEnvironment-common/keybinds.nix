{ lib, pkgs, ... }:
with lib;
let
  quickPoweroff = "${pkgs.systemd}/bin/systemctl poweroff";
  quickReboot = "${pkgs.systemd}/bin/systemctl reboot";
  quickSleep = "${pkgs.systemd}/bin/systemctl sleep";
  quickHibernate = "${pkgs.systemd}/bin/systemctl hibernate";

  audioMute = "${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
  audioRaiseVolume = "${pkgs.wireplumber}/bin/wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 2%+";
  audioLowerVolume = "${pkgs.wireplumber}/bin/wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 3%-";
  micMute = "${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
  micRaiseVolume = "${pkgs.wireplumber}/bin/wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SOURCE@ 4%+";
  micLowerVolume = "${pkgs.wireplumber}/bin/wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SOURCE@ 5%-";
  monBrightnessUp = "${getExe pkgs.brightnessctl} --exponent s 4%+";
  monBrightnessDown = "${getExe pkgs.brightnessctl} --exponent s 5%-";
  kbdBrightnessUp = "${getExe pkgs.brightnessctl} --device='*::kbd_backlight' s 10%+";
  kbdBrightnessDown = "${getExe pkgs.brightnessctl} --device='*::kbd_backlight' s 10%-";

  gnomeCharacters = "uwsm app -- ${getExe pkgs.gnome-characters}";
in
{
  #meta.doc = builtins.toFile "doc.md" ''
  #  Configures common keybinds for multiple desktop environments.
  #'';

  programs.umbriel.settings.keybinds = {
    "Mod+Control+Adiaeresis" = {
      action = "spawn:" + quickPoweroff;
      repeat = false;
    };
    "Mod+Control+Odiaeresis" = {
      action = "spawn:" + quickReboot;
      repeat = false;
    };
    "Mod+Control+Udiaeresis" = {
      action = "spawn:" + quickHibernate;
      repeat = false;
    };
    "Mod+Udiaeresis" = {
      action = "spawn:" + quickSleep;
      repeat = false;
    };

    "XF86AudioMute" = "spawn:" + audioMute;
    "Alt+XF86AudioMute" = "spawn:" + micMute;
    "XF86AudioMicMute" = "spawn:" + micMute;
    "XF86AudioRaiseVolume" = "spawn:" + audioRaiseVolume;
    "XF86AudioLowerVolume" = "spawn:" + audioLowerVolume;
    "Alt+XF86AudioRaiseVolume" = "spawn:" + micRaiseVolume;
    "Alt+XF86AudioLowerVolume" = "spawn:" + micLowerVolume;
    "XF86MonBrightnessUp" = "spawn:" + monBrightnessUp;
    "XF86MonBrightnessDown" = "spawn:" + monBrightnessDown;
    "XF86KbdBrightnessUp" = "spawn:" + kbdBrightnessUp;
    "XF86KbdBrightnessDown" = "spawn:" + kbdBrightnessDown;

    "Mod+Alt+U" = "spawn:" + gnomeCharacters;
  };
}
