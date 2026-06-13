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
  #  Configures common keybinds for every desktop environment.
  #  <https://wiki.hypr.land/Useful-Utilities/Must-have/>
  #'';

  wayland.windowManager.hyprland.settings = {
    bind = [
      {
        _args = [
          "SUPER + CONTROL + Adiaeresis"
          (mkLuaInline ''hl.dsp.exec_cmd("${quickPoweroff}")'')
          { description = "Power off"; }
        ];
      }
      {
        _args = [
          "SUPER + CONTROL + Odiaeresis"
          (mkLuaInline ''hl.dsp.exec_cmd("${quickReboot}")'')
          { description = "Reboot"; }
        ];
      }
      {
        _args = [
          "SUPER + CONTROL + Udiaeresis"
          (mkLuaInline ''hl.dsp.exec_cmd("${quickHibernate}")'')
          { description = "Hibernate"; }
        ];
      }
      {
        _args = [
          "SUPER + Udiaeresis"
          (mkLuaInline ''hl.dsp.exec_cmd("${quickSleep}")'')
          { description = "Sleep"; }
        ];
      }

      {
        _args = [
          "XF86AudioMute"
          (mkLuaInline ''hl.dsp.exec_cmd("${audioMute}")'')
          { description = "Audio mute"; }
        ];
      }
      {
        _args = [
          "ALT +XF86AudioMute"
          (mkLuaInline ''hl.dsp.exec_cmd("${micMute}")'')
          { description = "Mic mute"; }
        ];
      }
      {
        _args = [
          "XF86AudioMicMute"
          (mkLuaInline ''hl.dsp.exec_cmd("${micMute}")'')
          { description = "Mic mute"; }
        ];
      }
      {
        _args = [
          "XF86AudioRaiseVolume"
          (mkLuaInline ''hl.dsp.exec_cmd("${audioRaiseVolume}")'')
          {
            repeating = true;
            description = "Raise volume";
          }
        ];
      }
      {
        _args = [
          "XF86AudioLowerVolume"
          (mkLuaInline ''hl.dsp.exec_cmd("${audioLowerVolume}")'')
          {
            repeating = true;
            description = "Lower volume";
          }
        ];
      }
      {
        _args = [
          "ALT + XF86AudioRaiseVolume"
          (mkLuaInline ''hl.dsp.exec_cmd("${micRaiseVolume}")'')
          {
            repeating = true;
            description = "Raise volume";
          }
        ];
      }
      {
        _args = [
          "ALT + XF86AudioLowerVolume"
          (mkLuaInline ''hl.dsp.exec_cmd("${micLowerVolume}")'')
          {
            repeating = true;
            description = "Lower volume";
          }
        ];
      }
      {
        _args = [
          "XF86MonBrightnessUp"
          (mkLuaInline ''hl.dsp.exec_cmd("${monBrightnessUp}")'')
          {
            repeating = true;
            description = "Increase monitor brightness";
          }
        ];
      }
      {
        _args = [
          "XF86MonBrightnessDown"
          (mkLuaInline ''hl.dsp.exec_cmd("${monBrightnessDown}")'')
          {
            repeating = true;
            description = "Decrease monitor brightness";
          }
        ];
      }
      {
        _args = [
          "XF86KbdBrightnessUp"
          (mkLuaInline ''hl.dsp.exec_cmd("${kbdBrightnessUp}")'')
          {
            repeating = true;
            description = "Increase keyboard brightness";
          }
        ];
      }
      {
        _args = [
          "XF86KbdBrightnessDown"
          (mkLuaInline ''hl.dsp.exec_cmd("${kbdBrightnessDown}")'')
          {
            repeating = true;
            description = "Decrease keyboard brightness";
          }
        ];
      }

      {
        _args = [
          "SUPER + ALT + U"
          (mkLuaInline ''hl.dsp.exec_cmd("${gnomeCharacters}")'')
          { description = "Gnome characters"; }
        ];
      }
    ];
  };

  programs.niri.settings.binds = {
    "Mod+Control+Adiaeresis".action.spawn-sh = quickPoweroff;
    "Mod+Control+Odiaeresis".action.spawn-sh = quickReboot;
    "Mod+Control+Udiaeresis".action.spawn-sh = quickHibernate;
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

    "Mod+Alt+U".action.spawn-sh = gnomeCharacters;
  };
}
