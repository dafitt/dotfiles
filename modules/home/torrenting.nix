{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dafitt.torrenting;
in
{
  options.dafitt.torrenting = with types; {
    autostart = mkEnableOption "autostart at user login";
  };

  config = {
    home.packages = with pkgs; [ fragments ];

    programs.umbriel.settings = {
      general.autostart = mkIf cfg.autostart [ "fragments" ];
      keybinds."Mod+Alt+T" = {
        action = "scratchpad-toggle:torrenting";
        repeat = false;
      };
      scratchpad = [
        {
          name = "torrenting";
          spawn_when_empty = "fragments";
        }
      ];
      window_rule = [
        {
          match.app_id = "^torrenting$";
          default_scratchpad = "torrenting";
          default_floating_size = {
            width = 0.9;
            height = 0.9;
          };
          default_position = {
            anchor = "center";
            x = 0;
            y = 0;
          };
        }
      ];
    };
  };
}
