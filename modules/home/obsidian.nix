{
  config,
  lib,
  pkgs,
  osConfig ? { },
  ...
}:
with lib;
let
  cfg = config.dafitt.obidian;

  pkg = config.programs.obsidian.package;
in
{
  options.dafitt.obidian = with types; {
    setAsDefault = mkEnableOption "making it the default";

    autostart = mkEnableOption "autostart at user login";

    workspace = mkOption {
      type = int;
      default = 5;
      description = "Which workspace is mainly to be used for this application.";
    };
  };

  config = {
    # programs.obsidian.enable = true;
    home.packages = with pkgs; [
      obsidian

      # plugin dependencies
      typst
      pandoc
      imagemagick
    ];

    programs.umbriel.settings = {
      keybinds."Mod+Alt+H" = mkIf cfg.setAsDefault {
        action = "spawn:" + (getExe pkg);
        repeat = false;
      };
      general.autostart = optionals cfg.autostart [ (getExe pkg) ];
    };
  };
}
