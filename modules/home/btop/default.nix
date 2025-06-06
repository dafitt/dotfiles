{ config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.btop;
in
{
  options.dafitt.btop = with types; {
    enable = mkEnableOption "btop";
  };

  config = mkIf cfg.enable {
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

    wayland.windowManager.hyprland.settings = {
      bind = optionals config.dafitt.hyprland.pyprland.enable
        [ "SUPER_ALT, P, exec, ${pkgs.pyprland}/bin/pypr toggle btop" ];
    };

    dafitt.hyprland.pyprland.scratchpads.btop = {
      animation = "fromTop";
      command = "uwsm app -- ${getExe pkgs.kitty} --class btop ${getExe config.programs.btop.package} --update 3000";
      class = "btop";
      size = "90% 90%";
      margin = "2%";
      lazy = true;
    };
  };
}
