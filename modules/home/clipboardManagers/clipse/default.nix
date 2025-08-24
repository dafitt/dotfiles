{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.clipse;
in
{
  options.dafitt.clipse = with types; {
    enable = mkEnableOption "clipse";
    setAsDefaultClipboardManager = mkEnableOption "making clipse the default clipboard manager";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      clipse
    ];

    wayland.windowManager.hyprland.settings = {
      bind = mkIf cfg.setAsDefaultClipboardManager [
        "SUPER_ALT, V, exec, uwsm app -- ${getExe pkgs.kitty} --class=clipse -e ${getExe pkgs.clipse}"
      ];
      exec-once = [ "uwsm app -- ${getExe pkgs.clipse} -listen" ];
      windowrule = [
        "float, class:(clipse)"
        "size 622 652, class:(clipse)"
        "center, class:(clipse)"
      ];
    };
  };
}
