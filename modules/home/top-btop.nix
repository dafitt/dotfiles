{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib;
let
  cfg = config.dafitt.top-btop;
in
{
  imports = with inputs; [
    self.homeModules.pyprland
  ];

  options.dafitt.top-btop = with types; {
    setAsDefaultTop = mkEnableOption "making it the default TOP";
  };

  config = {
    programs.btop = {
      enable = true;
      settings = {
        # https://github.com/aristocratos/btop#configurability
        theme_background = false;
        update_ms = 100;
        presets = concatStringsSep " " [
          "cpu:0:default"
          "mem:0:default"
          "net:0:default"
          "proc:0:default"
        ]; # for ricing
      };
    };

    home.sessionVariables = mkIf cfg.setAsDefaultTop {
      TOP = "${getExe config.programs.btop.package}";
    };

    wayland.windowManager.hyprland.settings = {
      bind = optionals (config.dafitt.pyprland.enable && cfg.setAsDefaultTop) [
        "SUPER_ALT, P, exec, ${getExe pkgs.pyprland} toggle btop"
      ];
    };
    dafitt.pyprland.scratchpads.btop = {
      animation = "fromTop";
      command = "uwsm app -- ${getExe pkgs.kitty} --class btop ${getExe config.programs.btop.package} --update 3000";
      class = "btop";
      size = "90% 90%";
      margin = "2%";
      lazy = true;
    };
    programs.niri.settings = {
      binds."Mod+Alt+P" = mkIf cfg.setAsDefaultTop {
        action.spawn-sh = "uwsm app -- ${getExe pkgs.kitty} --class btop ${getExe config.programs.btop.package}";
      };
    };
  };
}
