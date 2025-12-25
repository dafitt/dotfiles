{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dafitt.clipboardManager-clipse;
in
{
  options.dafitt.clipboardManager-clipse = with types; {
    setAsDefaultClipboardManager = mkEnableOption "making it the default clipboard manager";
  };

  config = {
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
