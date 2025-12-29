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
      bind = optionals cfg.setAsDefaultClipboardManager [
        "SUPER_ALT, V, exec, uwsm app -- ${getExe pkgs.kitty} --class=clipse -e ${getExe pkgs.clipse}"
      ];
      exec-once = [ "uwsm app -- ${getExe pkgs.clipse} -listen" ];
      windowrule = [
        "noscreenshare, class:(clipse)"
        "float, class:(clipse)"
        "size 622 652, class:(clipse)"
        "center, class:(clipse)"
      ];
    };
    programs.niri.settings = {
      binds."Mod+Alt+V" = mkIf cfg.setAsDefaultClipboardManager {
        action.spawn-sh = "uwsm app -- ${getExe pkgs.kitty} --class=clipse -e ${getExe pkgs.clipse}";
        spawn-at-startup = optionals cfg.autostart [
          { sh = "uwsm app -- ${getExe pkgs.clipse} -listen"; }
        ];
      };
      window-rules = [
        {
          matches = [ { app-id = "clipse"; } ];
          open-floating = true;
          block-out-from = "screen-capture";
        }
      ];
    };
  };
}
