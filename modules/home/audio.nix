{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib;
{
  #meta.doc = builtins.toFile "doc.md" "Installs and configures pavucontrol audio control.";

  imports = with inputs; [
    self.homeModules.pyprland
  ];

  home.packages = with pkgs; [ pavucontrol ];

  wayland.windowManager.hyprland.settings = {
    bind = optionals config.dafitt.pyprland.enable [
      {
        _args = [
          "SUPER + ALT + A"
          (mkLuaInline ''hl.dsp.exec_cmd("${pkgs.pyprland}/bin/pypr toggle audio")'')
          { description = "Open audio scratchpad"; }
        ];
      }
    ];
    window_rule = [
      {
        match.class = "pavucontrol";
        match.title = "^Volume Control$";
        float = true;
      }
    ];
  };

  dafitt.pyprland.scratchpads.audio = {
    animation = "fromLeft";
    command = "uwsm app -- ${getExe pkgs.pavucontrol}";
    class = "org.pulseaudio.pavucontrol";
    size = "40% 70%";
    lazy = true;
  };

  programs.umbriel.settings = {
    keybinds."Mod+Alt+A" = {
      action = "scratchpad-toggle:monitor";
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
        match.app_id = "^org.pulseaudio.pavucontrol$";
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
