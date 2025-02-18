{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.clipboardManagers.clipse;
in
{
  options.dafitt.clipboardManagers.clipse = with types; {
    enable = mkEnableOption "clipboard manager 'clipse'";

    configureKeybindings = mkBoolOpt false "Whether to configure keybindings.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      clipse
    ];

    wayland.windowManager.hyprland.settings = {
      bind = mkIf cfg.configureKeybindings [
        "SUPER_ALT, V, exec, uwsm app -- ${getExe pkgs.kitty} --class=clipse -e ${getExe pkgs.clipse}"
      ];
      exec-once = [ "uwsm app -- ${getExe pkgs.clipse} -listen" ];
      windowrulev2 = [
        "float, class:(clipse)"
        "size 622 652, class:(clipse)"
        "center, class:(clipse)"
      ];
    };
  };
}
