{ config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.launchers.fuzzel;
in
{
  options.dafitt.launchers.fuzzel = with types; {
    enable = mkEnableOption "application launcher 'fuzzel'";

    configureKeybindings = mkBoolOpt false "Whether to configure keybindings.";
  };

  config = mkIf cfg.enable {
    dafitt.stylix.enable = true;

    # Application launcher for wlroots based Wayland compositors
    # https://codeberg.org/dnkl/fuzzel
    programs.fuzzel = {
      enable = true;
      settings = {
        main = {
          # [settings](https://man.archlinux.org/man/fuzzel.ini.5.en)
          launch-prefix = "uwsm app -- ";
          terminal = config.home.sessionVariables.TERMINAL;
          font = lib.mkForce "${config.stylix.fonts.serif.name}:size=16";
          letter-spacing = 1;
          icon-theme = "${config.gtk.iconTheme.name}";
          layer = "overlay";
        };
        border = {
          width = 2;
          #radius = 0;
        };
      };
    };

    wayland.windowManager.hyprland.settings = {
      bind = mkIf cfg.configureKeybindings [ "SUPER, SPACE, exec, ${config.programs.fuzzel.package}/bin/fuzzel" ];
    };
  };
}
