{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  launchersCfg = config.dafitt.environment.launchers;
  cfg = launchersCfg.fuzzel;

  isDefault = launchersCfg.default == "fuzzel";
in
{
  options.dafitt.environment.launchers.fuzzel = with types; {
    enable = mkBoolOpt (config.dafitt.desktops.hyprland.enable && isDefault) "Enable the application launcher fuzzel";
  };

  config = mkIf cfg.enable {
    # Application launcher for wlroots based Wayland compositors
    # https://codeberg.org/dnkl/fuzzel
    programs.fuzzel = {
      enable = true;
      settings = {
        main = {
          # [settings](https://man.archlinux.org/man/fuzzel.ini.5.en)
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

    wayland.windowManager.hyprland.settings = mkIf isDefault {
      bind = [ "SUPER, SPACE, exec, ${config.programs.fuzzel.package}/bin/fuzzel" ];
    };
  };
}
