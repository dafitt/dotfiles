{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dafitt.top-btop;
in
{
  #meta.doc = builtins.toFile "doc.md" "Installs and configures btop.";

  options.dafitt.top-btop = with types; {
    setAsDefaultTop = mkEnableOption "making it the default TOP";
  };

  config = {
    programs.btop = {
      enable = true;
      settings = {
        # https://github.com/aristocratos/btop#configurability
        theme_background = false;
        update_ms = 100;
        presets = concatStringsSep " " [
          "cpu:0:default"
          "mem:0:default"
          "net:0:default"
          "proc:0:default"
        ]; # for ricing
      };
    };

    home.sessionVariables = mkIf cfg.setAsDefaultTop {
      TOP = "${getExe config.programs.btop.package}";
    };

    programs.umbriel.settings = {
      keybinds."Mod+Alt+P" = {
        action = "scratchpad-toggle:monitor";
        repeat = false;
      };
      scratchpad = [
        {
          name = "monitor";
          spawn_when_empty = "${getExe pkgs.kitty} --class btop ${getExe config.programs.btop.package} --update 3000";
        }
      ];
      window_rule = [
        {
          match.app_id = "^btop$";
          default_scratchpad = "monitor";
          default_floating_size = {
            width = 0.9;
            height = 0.9;
          };
          default_position = {
            anchor = "top";
            x = 0;
            y = 0;
          };
        }
      ];
    };
  };
}
