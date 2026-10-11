{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib;
{
  #meta.doc = builtins.toFile "doc.md" "Adds NetworkManager network control.";

  imports = with inputs; [
    self.homeModules.pyprland
  ];

  wayland.windowManager.hyprland.settings = {
    bind = optionals config.dafitt.pyprland.enable [
      {
        _args = [
          "SUPER + ALT + N"
          (mkLuaInline ''hl.dsp.exec_cmd("${getExe pkgs.pyprland} toggle networkmanager")'')
          { description = "Toggle NetworkManager scratchpad"; }
        ];
      }
    ];
    window_rule = [
      {
        match.class = "nm-connection-editor";
        float = true;
      }
    ];
  };
  dafitt.pyprland.scratchpads.networkmanager = {
    animation = "fromLeft";
    command = "uwsm app -- ${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
    class = "nm-connection-editor";
    size = "40% 70%";
    lazy = true;
  };
  programs.umbriel.settings = {
    keybinds."Mod+Alt+N" = {
      action = "scratchpad-toggle:network";
      repeat = false;
    };
    scratchpad = [
      {
        name = "network";
        spawn_when_empty = "${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
      }
    ];
    window_rule = [
      {
        match.app_id = "^nm-connection-editor$";
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
