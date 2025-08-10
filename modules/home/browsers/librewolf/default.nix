{ config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.browsers.librewolf;
in
{
  options.dafitt.browsers.librewolf = with types; {
    enable = mkEnableOption "browser 'librewolf'";

    autostart = mkBoolOpt false "Whether to autostart at user login.";
    configureKeybindings = mkBoolOpt false "Whether to configure keybindings.";
    workspace = mkOpt int 1 "Which workspace is mainly to be used for this application.";
  };

  config = mkIf cfg.enable {
    # a fork of Firefox, focused on privacy, security and freedom
    # https://librewolf.net/
    programs.librewolf = {
      enable = true;
      settings = config.programs.firefox.profiles.${config.home.username}.settings // { };

      # https://github.com/HeitorAugustoLN/betterfox-nix
      betterfox = {
        enable = true;
        settings = {
          enable = true;
          enableAllSections = true;
        };
      };
    };

    wayland.windowManager.hyprland.settings = {
      bind = mkIf cfg.configureKeybindings [ "SUPER_ALT, W, exec, uwsm app -- ${config.programs.librewolf.package}/bin/librewolf" ];
      exec-once = mkIf cfg.autostart [ "[workspace ${toString cfg.workspace} silent] uwsm app -- ${config.programs.librewolf.package}/bin/librewolf" ];
      windowrule = [
        "idleinhibit fullscreen, class:librewolf, title:(Youtube)"
        "float, class:librewolf, title:^Extension: \(NoScript\) - NoScript"
        #FIXME initial title is librewolf
        #TODO no fullscreen
      ];
    };

    # needs inputs.xdg-autostart.homeManagerModules.xdg-autostart
    xdg.autoStart.packages = mkIf cfg.autostart [ config.programs.librewolf.package ];
  };
}
