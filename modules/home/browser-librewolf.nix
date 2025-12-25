{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.dafitt.browser-librewolf;
in
{
  options.dafitt.browser-librewolf = with types; {
    setAsDefaultBrowser = mkEnableOption "making it the default web browser";

    autostart = mkOption {
      type = bool;
      default = cfg.setAsDefaultBrowser;
      description = "Whether to autostart at user login.";
    };
    workspace = mkOption {
      type = int;
      default = 1;
      description = "Which workspace is mainly to be used for this application.";
    };
  };

  config = {
    # a fork of Firefox, focused on privacy, security and freedom
    # https://librewolf.net/
    programs.librewolf = {
      enable = true;
      settings = config.programs.firefox.profiles.${config.home.username}.settings // { };
    };

    wayland.windowManager.hyprland.settings = {
      bind = mkIf cfg.setAsDefaultBrowser [
        "SUPER_ALT, W, exec, uwsm app -- ${config.programs.librewolf.package}/bin/librewolf"
      ];
      exec-once = mkIf cfg.autostart [
        "[workspace ${toString cfg.workspace} silent] uwsm app -- ${config.programs.librewolf.package}/bin/librewolf"
      ];
      windowrule = [
        "idleinhibit fullscreen, class:librewolf, title:(Youtube)"
        "float, class:librewolf, title:^Extension: \(NoScript\) - NoScript"
        #FIXME initial title is librewolf
        #TODO no fullscreen
      ];
    };
  };
}
