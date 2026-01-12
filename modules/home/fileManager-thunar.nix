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
      ];

      dbus.packages = with pkgs; [
        thunar
        tumbler
      ];

      # How to fix default terminal not found:
      #$ nix shell nixpkgs#xfce.xfce4-settings
      #$ xfce4-mime-settings

      wayland.windowManager.hyprland.settings = {
        bind = optionals cfg.setAsDefaultFileManager [
          "Super&Alt, F, exec, uwsm app -- ${thunar}/bin/thunar"
        ];
        exec-once = optionals cfg.autostart [
          "[workspace ${toString cfg.workspace} silent] uwsm app -- ${thunar}/bin/thunar"
        ];
        windowrule = [
          "match:class thunar$, match:title ^Rename, float on"
        ];
      };
      programs.niri.settings = {
        binds."Mod+Alt+F" = mkIf cfg.setAsDefaultFileManager {
          action.spawn-sh = "uwsm app -- ${thunar}/bin/thunar";
        };
        spawn-at-startup = optionals cfg.autostart [
          { sh = "uwsm app -- ${thunar}/bin/thunar"; }
        ];
        window-rules = [
          {
            matches = [ { app-id = "thunar$"; } ];
            open-floating = true;
          }
        ];
      };
    };
}
