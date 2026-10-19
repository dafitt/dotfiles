{
  flake,
  lib,
  config,
  inputs,
  pkgs,
  osConfig ? { },
  ...
}:
with lib;
let
  cfg = config.dafitt.MODULE;

  exe = getExe config.programs.MODULE.package;
in
{
  #meta.doc = builtins.toFile "doc.md" "A module that does something.";

  imports = with inputs; [
    self.homeModules.home-manager-mutableFiles
  ];

  options.dafitt.MODULE = with types; {
    setAsDefault = mkEnableOption "making it the default";

    autostart = mkEnableOption "autostart at user login";

    workspace = mkOption {
      type = int;
      default = 5;
      description = "Which workspace is mainly to be used for this application.";
    };
  };

  config = {
    home.packages = with pkgs; [ MODULE ];

    programs.MODULE.enable = true;
    xdg.configFile = flake.lib.mkMutableFiles (
      optional (config.programs.MODULE.settings != { }) "MODULE/config"
    );

    programs.umbriel.settings = {
      keybinds."Mod+Alt+?" = mkIf cfg.setAsDefault {
        action = "spawn:${exe}";
        repeat = false;
      };
      general.autostart = optional cfg.autostart exe;
      window_rule = [
        {
          match.app_id = "^MODULE$";
          default_workspace = cfg.workspace;
          default_floating = true;
        }
      ];
    };
  };
}
