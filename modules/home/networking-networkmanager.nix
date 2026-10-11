{ pkgs, ... }:
{
  #meta.doc = builtins.toFile "doc.md" "Adds NetworkManager network control.";

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
