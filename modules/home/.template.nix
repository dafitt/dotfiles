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

    programs.umbriel.settings = {
      keybinds."Mod+Alt+?" = mkIf cfg.setAsDefault {
        action = "spawn:${getExe pkgs.MODULE}";
        repeat = false;
      };
      general.autostart = optionals cfg.autostart [ (getExe pkgs.MODULE) ];
      window_rule = [
        {
          match.app_id = "MODULE$";
          default_floating = true;
        }
      ];
    };
    xdg.configFile = flake.lib.mkMutableFiles [ "MODULE/config" ];
  };
}
