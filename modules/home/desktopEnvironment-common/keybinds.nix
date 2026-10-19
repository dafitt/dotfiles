{ lib, pkgs, ... }:
with lib;
let
  lock = "${pkgs.systemd}/bin/loginctl lock-session";
  quickSleep = "${lock} && ${pkgs.systemd}/bin/systemctl sleep";
  quickHibernate = "${lock} && ${pkgs.systemd}/bin/systemctl hibernate";
  quickReboot = "${pkgs.systemd}/bin/systemctl reboot";
  quickPoweroff = "${pkgs.systemd}/bin/systemctl poweroff";

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

  textOcr = ''${getExe pkgs.grim} -g "$(${getExe pkgs.slurp})" - | ${getExe pkgs.tesseract} - - -l deu+eng | wl-copy'';

  gnomeCharacters = "${getExe pkgs.gnome-characters}";
in
{
  #meta.doc = builtins.toFile "doc.md" ''
  #  Configures common keybinds for multiple desktop environments.
  #'';

  programs.umbriel.settings.keybinds = {
    "Mod+L" = {
      action = "spawn:${lock}";
      repeat = false;
    };
    "Mod+Udiaeresis" = {
      action = "spawn:" + quickSleep;
      repeat = false;
    };
    "Mod+Control+Udiaeresis" = {
      action = "spawn:" + quickHibernate;
      repeat = false;
    };
    "Mod+Control+Odiaeresis" = {
      action = "spawn:" + quickReboot;
      repeat = false;
    };
    "Mod+Control+Adiaeresis" = {
      action = "spawn:" + quickPoweroff;
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

    "Mod+T" = "spawn:" + textOcr;
    "Mod+Alt+U" = "spawn:" + gnomeCharacters;
  };
}
