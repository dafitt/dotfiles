{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.btop;
in
{
  options.dafitt.btop = with types; {
    enable = mkBoolOpt true "Enable btop.";
  };

  config = mkIf cfg.enable {
    programs.btop = {
      enable = true;
      settings = {
        # https://github.com/aristocratos/btop#configurability
        theme_background = false;
        presets = concatStringsSep " " [
          "cpu:0:default"
          "mem:0:default"
          "net:0:default"
          "proc:0:default"
        ]; # for ricing
      };
    };

    wayland.windowManager.hyprland.settings = {
      bind = optionals config.dafitt.desktops.hyprland.pyprland.enable
        [ "SUPER_ALT, P, exec, ${pkgs.pyprland}/bin/pypr toggle btop" ];
    };

    dafitt.desktops.hyprland.pyprland.scratchpads.btop = {
      animation = "fromTop";
      command = "${config.home.sessionVariables.TERMINAL} --class btop ${getExe config.programs.btop.package}";
      class = "btop";
      size = "90% 90%";
      margin = "2%";
      lazy = true;
    };
  };
}
