{
  config,
  lib,
  inputs,
  ...
}:
with lib;
let
  cfg = config.dafitt.launcher-fuzzel;
in
{
  imports = with inputs; [
    self.homeModules.stylix
  ];

  options.dafitt.launcher-fuzzel = with types; {
    setAsDefaultLauncher = mkEnableOption "making it the default launcher";
  };

  config = {
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
      bind = mkIf cfg.setAsDefaultLauncher [
        "Super, SPACE, exec, ${config.programs.fuzzel.package}/bin/fuzzel"
      ];
    };
    programs.niri.settings.binds = mkIf cfg.setAsDefaultLauncher {
      "Mod+Space".action.spawn = "${config.programs.fuzzel.package}/bin/fuzzel";
    };
  };
}
