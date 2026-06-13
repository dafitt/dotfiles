{ lib, config, ... }:
with lib;
{
  #meta.doc = builtins.toFile "doc.md" "Installs and configures playerctl media control daemon.";

  services.playerctld.enable = true;

  wayland.windowManager.hyprland.settings = {
    bind = [
      {
        _args = [
          "XF86AudioPlay"
          (mkLuaInline ''hl.dsp.exec_cmd("${config.services.playerctld.package}/bin/playerctl play-pause")'')
        ];
      }
      {
        _args = [
          "XF86AudioPause"
          (mkLuaInline ''hl.dsp.exec_cmd("${config.services.playerctld.package}/bin/playerctl play-pause")'')
        ];
      }
      {
        _args = [
          "XF86AudioStop"
          (mkLuaInline ''hl.dsp.exec_cmd("${config.services.playerctld.package}/bin/playerctl stop")'')
        ];
      }
      {
        _args = [
          "XF86AudioNext"
          (mkLuaInline ''hl.dsp.exec_cmd("${config.services.playerctld.package}/bin/playerctl next")'')
        ];
      }
      {
        _args = [
          "XF86AudioPrev"
          (mkLuaInline ''hl.dsp.exec_cmd("${config.services.playerctld.package}/bin/playerctl previous")'')
        ];
      }
      {
        _args = [
          "CTRL + XF86AudioRaiseVolume"
          (mkLuaInline ''hl.dsp.exec_cmd("${config.services.playerctld.package}/bin/playerctl position 1+")'')
        ];
      }
      {
        _args = [
          "CTRL + XF86AudioLowerVolume"
          (mkLuaInline ''hl.dsp.exec_cmd("${config.services.playerctld.package}/bin/playerctl position 1-")'')
        ];
      }
      {
        _args = [
          "ALT + XF86AudioNext"
          (mkLuaInline ''hl.dsp.exec_cmd("${config.services.playerctld.package}/bin/playerctld shift")'')
        ];
      }
      {
        _args = [
          "ALT + XF86AudioPrev"
          (mkLuaInline ''hl.dsp.exec_cmd("${config.services.playerctld.package}/bin/playerctld unshift")'')
        ];
      }
      {
        _args = [
          "ALT + XF86AudioPlay"
          (mkLuaInline ''hl.dsp.exec_cmd("systemctl --user restart playerctld")'')
          { description = "Restart playerctld"; }
        ];
      }
    ];
  };
  programs.niri.settings.binds = {
    "XF86AudioPlay".action.spawn-sh = "${config.services.playerctld.package}/bin/playerctl play-pause";
    "XF86AudioPause".action.spawn-sh = "${config.services.playerctld.package}/bin/playerctl play-pause";
    "XF86AudioStop".action.spawn-sh = "${config.services.playerctld.package}/bin/playerctl stop";
    "XF86AudioNext".action.spawn-sh = "${config.services.playerctld.package}/bin/playerctl next";
    "XF86AudioPrev".action.spawn-sh = "${config.services.playerctld.package}/bin/playerctl previous";
    "Control+XF86AudioRaiseVolume".action.spawn-sh =
      "${config.services.playerctld.package}/bin/playerctl position 1+";
    "Control+XF86AudioLowerVolume".action.spawn-sh =
      "${config.services.playerctld.package}/bin/playerctl position 1-";
    "Alt+XF86AudioNext".action.spawn-sh = "${config.services.playerctld.package}/bin/playerctld shift";
    "Alt+XF86AudioPrev".action.spawn-sh =
      "${config.services.playerctld.package}/bin/playerctld unshift";
    "Alt+XF86AudioPlay".action.spawn-sh = "systemctl --user restart playerctld";
  };
}
