{ lib, config, ... }:
with lib;
{
  #meta.doc = builtins.toFile "doc.md" "Installs and configures playerctl media control daemon.";

  services.playerctld.enable = true;

  programs.umbriel.settings.keybinds = {
    "XF86AudioPlay" = {
      action = "spawn:" + "${config.services.playerctld.package}/bin/playerctl play-pause";
      repeat = false;
    };
    "XF86AudioPause" = {
      action = "spawn:" + "${config.services.playerctld.package}/bin/playerctl play-pause";
      repeat = false;
    };
    "XF86AudioStop" = {
      action = "spawn:" + "${config.services.playerctld.package}/bin/playerctl stop";
      repeat = false;
    };
    "XF86AudioNext" = {
      action = "spawn:" + "${config.services.playerctld.package}/bin/playerctl next";
      repeat = false;
    };
    "XF86AudioPrev" = {
      action = "spawn:" + "${config.services.playerctld.package}/bin/playerctl previous";
      repeat = false;
    };
    "Control+XF86AudioRaiseVolume" = {
      action = "spawn:" + "${config.services.playerctld.package}/bin/playerctl position 1+";
    };
    "Control+XF86AudioLowerVolume" = {
      action = "spawn:" + "${config.services.playerctld.package}/bin/playerctl position 1-";
    };
    "Alt+XF86AudioNext" = {
      action = "spawn:" + "${config.services.playerctld.package}/bin/playerctld shift";
    };
    "Alt+XF86AudioPrev" = {
      action = "spawn:" + "${config.services.playerctld.package}/bin/playerctld unshift";
    };
    "Alt+XF86AudioPlay" = {
      action = "spawn:systemctl --user restart playerctld";
      repeat = false;
    };
  };
}
