{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib;
{
  #meta.doc = builtins.toFile "doc.md" "Adds Connman network control.";

  imports = with inputs; [
    self.homeModules.pyprland
  ];

  wayland.windowManager.hyprland.settings = {
    bind = optionals config.dafitt.pyprland.enable [
      {
        _args = [
          "SUPER + ALT + N"
          (mkLuaInline ''hl.dsp.exec_cmd("${getExe pkgs.pyprland} toggle connman")'')
          { description = "Toggle connman scratchpad"; }
        ];
      }
    ];
    window_rule = [
      {
        match.class = "connman-gtk";
        float = true;
      }
    ];
  };
  dafitt.pyprland.scratchpads.connman = {
    animation = "fromLeft";
    command = "uwsm app -- ${pkgs.connman-gtk}/bin/connman-gtk";
    class = "connman-gtk";
    size = "40% 70%";
    lazy = true;
  };
  programs.niri.settings = {
    binds."Mod+Alt+N".action.spawn-sh = "uwsm app -- ${pkgs.connman-gtk}/bin/connman-gtk";
  };
  programs.umbriel.settings = {
    keybinds."Mod+Alt+N" = {
      action = "scratchpad-toggle:network";
      repeat = false;
    };
    scratchpad = [
      {
        name = "network";
        spawn_when_empty = "${pkgs.connman-gtk}/bin/connman-gtk";
      }
    ];
    window_rule = [
      {
        match.app_id = "^connman-gtk$";
        default_scratchpad = "network";
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
