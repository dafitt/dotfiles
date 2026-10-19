{
  lib,
  inputs,
  pkgs,
  ...
}:
with lib;
{
  #meta.doc = builtins.toFile "doc.md" "Installs and configures pavucontrol audio control.";

  home.packages = with pkgs; [ pavucontrol ];

  programs.umbriel.settings = {
    keybinds."Mod+Alt+A" = {
      action = "scratchpad-toggle:audio";
      repeat = false;
    };
    scratchpad = [
      {
        name = "audio";
        spawn_when_empty = (getExe pkgs.pavucontrol);
      }
    ];
    window_rule = [
      {
        match.app_id = "^org[.]pulseaudio[.]pavucontrol$";
        default_scratchpad = "audio";
        default_floating_size = {
          width = 0.4;
          height = 0.7;
        };
        default_position = {
          anchor = "left";
          x = 0;
          y = 0;
        };
      }
    ];
  };
}
