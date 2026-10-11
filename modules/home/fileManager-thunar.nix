{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dafitt.fileManager-thunar;
in
{
  #meta.doc = builtins.toFile "doc.md" "Installs and configures the Thunar file manager.";
  # How to fix default terminal not found:
  #$ xfce4-mime-settings

  options.dafitt.fileManager-thunar = with types; {
    setAsDefaultFileManager = mkEnableOption "making it the default file manager";

    autostart = mkEnableOption "autostart at user login";

    workspace = mkOption {
      type = int;
      default = 3;
      description = "Which workspace is mainly to be used for this application.";
    };
  };

  config =
    let
      thunar = pkgs.thunar.override {
        thunarPlugins = with pkgs; [
          thunar-archive-plugin
          thunar-media-tags-plugin
          thunar-vcs-plugin
        ];
      };
    in
    {
      home.packages = with pkgs; [
        thunar
        tumbler
        xfce4-settings
      ];

      dbus.packages = with pkgs; [
        thunar
        tumbler
      ];

      xfconf.settings.thunar = {
        "last-restore-tabs" = true;
        "misc-date-style" = "THUNAR_DATE_STYLE_YYYYMMDD";
        "misc-middle-click-in-tab" = true;
        "misc-show-delete-action" = true;
      };

      programs.umbriel.settings = {
        keybinds."Mod+Alt+F" = mkIf cfg.setAsDefaultFileManager {
          action = "spawn:${thunar}/bin/thunar";
          repeat = false;
        };
        general.autostart = optionals cfg.autostart [ "${thunar}/bin/thunar" ];
        window_rule = [
          {
            match.app_id = "thunar$";
            default_floating = true;
          }
        ];
      };
    };
}
