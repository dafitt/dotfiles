{
  inputs,
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.dafitt.browser-librewolf;
in
{
  #meta.doc = builtins.toFile "doc.md" ''
  #  Installs and configures the LibreWolf web browser.
  #  https://librewolf.net/
  #'';

  imports = with inputs; [
    self.homeModules.web-utils
  ];

  options.dafitt.browser-librewolf = with types; {
    setAsDefaultBrowser = mkEnableOption "making it the default web browser";

    autostart = mkEnableOption "autostart at user login";

    workspace = mkOption {
      type = int;
      default = 1;
      description = "Which workspace is mainly to be used for this application.";
    };
  };

  config = {
    programs.librewolf.enable = true;
    programs.librewolf.profiles.${config.home.username} = {
      settings = config.programs.firefox.profiles.${config.home.username}.settings // { };

      userChrome = config.programs.firefox.profiles.${config.home.username}.userChrome + "";

      extensions.packages =
        with perSystem.nur.repos.rycee.firefox-addons;
        config.programs.firefox.profiles.${config.home.username}.extensions.packages ++ [ ];

      # search = config.programs.firefox.profiles.${config.home.username}.search // { };
    };

    programs.umbriel.settings = {
      keybinds."Mod+Alt+W" = mkIf cfg.setAsDefaultBrowser {
        action = "spawn:${getExe config.programs.librewolf.package}";
        repeat = false;
      };
      general.autostart = optionals cfg.autostart [ (getExe config.programs.librewolf.package) ];
      window_rule = [
        {
          match.app_id = "^librewolf$";
          default_workspace = cfg.workspace;
        }
        {
          match.app_id = "^librewolf$";
          match.title = "^Extension: \(NoScript\) - NoScript";
          default_floating = true;
        }
      ];
    };
  };
}
