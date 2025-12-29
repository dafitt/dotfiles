{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dafitt.clipboardManager-cliphist;
in
{
  options.dafitt.clipboardManager-cliphist = with types; {
    setAsDefaultClipboardManager = mkEnableOption "making it the default clipboard manager";
  };

  config = {
    home.packages = with pkgs; [
      wl-clipboard-rs
    ];

    # Wayland clipboard manager
    # https://github.com/sentriz/cliphist
    services.cliphist.enable = true;

    # in addition to https://github.com/nix-community/home-manager/blob/master/modules/services/cliphist.nix
    systemd.user.services.cliphist.Service = {
      ExecStop = "${config.services.cliphist.package}/bin/cliphist wipe";
    };

    # simple cliphist selector
    wayland.windowManager.hyprland.settings = {
      bind = optionals cfg.setAsDefaultClipboardManager [
        "SUPER_ALT, V, exec, uwsm app -- ${getExe pkgs.kitty} --class=cliphist -e sh -c '${config.services.cliphist.package}/bin/cliphist list | ${pkgs.fzf}/bin/fzf | ${config.services.cliphist.package}/bin/cliphist decode | ${pkgs.wl-clipboard}/bin/wl-copy'"
      ];
      windowrule = [
        "noscreenshare, class:(cliphist)"
        "float, class:(cliphist)"
        "size 622 652, class:(cliphist)"
        "center, class:(cliphist)"
      ];
    };
    programs.niri.settings = {
      binds."Mod+Alt+V" = mkIf cfg.setAsDefaultClipboardManager {
        action.spawn-sh = "uwsm app -- ${getExe pkgs.kitty} --class=cliphist -e sh -c '${config.services.cliphist.package}/bin/cliphist list | ${pkgs.fzf}/bin/fzf | ${config.services.cliphist.package}/bin/cliphist decode | ${pkgs.wl-clipboard}/bin/wl-copy'";
      };
      window-rules = [
        {
          matches = [
            { app-id = "cliphist"; }
          ];
          open-floating = true;
          block-out-from = "screen-capture";
        }
      ];
    };
  };
}
